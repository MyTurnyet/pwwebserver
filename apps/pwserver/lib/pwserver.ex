defmodule PW.Server do
  require Logger


  def listen(tcp_wrapper \\ :gen_tcp, port_number \\ 8091) do
    Logger.info("Opening listener on port #{port_number}")

    {:ok, port_socket} =
      tcp_wrapper.listen(port_number, [:binary, packet: :line, active: false, reuseaddr: true])

    loop_acceptor(tcp_wrapper, port_socket)
  end

  def loop_acceptor(tcp_wrapper, socket) do
    {:ok, client} = tcp_wrapper.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(PW.Server.TaskSupervisor, fn -> serve(tcp_wrapper, client) end)

    tcp_wrapper.controlling_process(client, pid)

    loop_acceptor(tcp_wrapper, socket)
  end

  def serve(tcp_wrapper, socket) do
    socket
    |> read_request(tcp_wrapper)
    |> write_response(tcp_wrapper, socket)
  end

  def read_request(socket, tcp_wrapper) do
     receive_data(tcp_wrapper, socket, [])
    |> create_response
  end

  def create_response({:ok, _data}) do
    Logger.info("Returning the connection")
    "HTTP/1.1 200 OK\r\n\r\n"
  end

  def create_response({:error, :closed}) do
    Logger.info("Connection Closed")
    {:error, :closed}
  end

  defp write_response(line, tcp_wrapper, socket) do
    Logger.info("Sending back: #{line}")
    tcp_wrapper.send(socket, line)
    line
  end

  def receive_data(tcp_wrapper, socket, data) do
    case tcp_wrapper.recv(socket,0) do
        {:ok, line} ->
          Logger.info("Received this data: #{data}")
          Logger.info("line == #{line}")
          if line == "\r\n" do
            {:ok, data}
          else
            receive_data(tcp_wrapper, socket, [data, line])
          end
         _ ->
          Logger.info("Error!")
    end
  end
end
