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

    {:ok, pid} =
      Task.Supervisor.start_child(PW.Server.TaskSupervisor, fn -> serve(tcp_wrapper, client) end)

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
    |> parse_request
    |> create_response
  end

  def parse_request({:ok, request_message}) do
    [first_line | _] = request_message
    Logger.info("first_line: #{first_line}")
    [request_type, path, _] = String.split(first_line, " ")
    %{:request_type => String.upcase(request_type), :path => path}
  end

  def create_response(request) do
    Logger.info(request.path)
    PW.HttpHandler.handle_request(request)
  end

  defp write_response(line, tcp_wrapper, socket) do
    tcp_wrapper.send(socket, line)
  end

  def receive_data(tcp_wrapper, socket, data) do
    case tcp_wrapper.recv(socket, 0) do
      {:ok, line} ->
        if line == "\r\n" do
          {:ok, data}
        else
          new_data = data ++ [line]
          receive_data(tcp_wrapper, socket, new_data)
        end

      _ ->
        Logger.info("Error!")
    end
  end
end
