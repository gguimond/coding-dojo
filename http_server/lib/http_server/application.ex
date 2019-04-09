defmodule HTTPServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    port = Application.get_env(:http_server, :cowboy_port, 8099)
    children = [
      # Starts a worker by calling: HTTPServer.Worker.start_link(arg)
      # {HTTPServer.Worker, arg},
      {
        Plug.Adapters.Cowboy2,
        scheme: :http,
        plug: HTTPServer.MyRouter,
        options: [port: port]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HTTPServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
