defmodule PW.HTTPHost do
  require Logger

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def listen(port_number \\ 8091) do
    Logger.info("Opening listener on port #{port_number}")

    {:ok, port_socket} =
      :gen_tcp.listen(port_number, [:binary, packet: :line, active: false, reuseaddr: true])

    loop_acceptor(port_socket)
  end

  def loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    serve(client)
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
    {:ok, data} = :gen_tcp.recv(socket, 0)
    Logger.info("reading the line: #{data}")
    data
  end

  defp write_line(line, socket) do
    Logger.info("sending it back")
    :gen_tcp.send(socket, line)
  end
end
