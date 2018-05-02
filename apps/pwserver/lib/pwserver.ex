defmodule PW.Server do
  require Logger

  def listen(port_number \\ 8091) do
    Logger.info("Opening listener on port #{port_number}")

    {:ok, port_socket} =
      :gen_tcp.listen(port_number, [:binary, packet: :line, active: false, reuseaddr: true])

    loop_acceptor(port_socket)
  end

  def loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(PW.Server.TaskSupervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    Logger.info("recieved data")

    socket
    |> read_line()
    |> write_line(socket)

    serve(socket)
  end

  defp read_line(socket) do
    # {:ok, data} = :gen_tcp.recv(socket, 0)
    :gen_tcp.recv(socket, 0)
    |> read_open_connection
  end

  defp read_open_connection({:ok, data}) do
    # {:ok, data} = response
    Logger.info("reading the line: #{data}")
    data
  end

  defp read_open_connection({:error, :closed}) do
    Logger.info("Connection Closed")
    "connection closed"
  end

  defp write_line(line, socket) do
    Logger.info("sending it back")
    :gen_tcp.send(socket, line)
  end
end
