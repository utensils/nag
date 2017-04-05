defmodule Nag do
  @moduledoc """
  Nag OTP application
  """

  use Application

  require Logger

  alias Nag.{Router, Shell}
  alias Plug.Adapters.Cowboy

  @cowboy_opts [ip: {0, 0, 0, 0}, port: 4000]
  @file_permission 0o755
  @script_path Application.get_env(:nag, :script_path)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Task.Supervisor, [[name: :tasks_sup]]),
      worker(Nag, [], function: :run)
    ]

    opts = [strategy: :one_for_one, name: Nag.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    setup
    print_server_location
    {:ok, _pid} = Cowboy.http(Router, @cowboy_opts)
  end

  defp pretty_ip do
    @cowboy_opts
    |> Keyword.get(:ip)
    |> Tuple.to_list
    |> Enum.join(".")
  end

  defp print_server_location,
    do: Logger.info("Online at #{pretty_ip}:#{@cowboy_opts[:port]}")

  defp setup do
    chmod_script
    install_gems
  end

  defp chmod_script,
    do: File.chmod(@script_path, @file_permission)

  defp install_gems,
    do: Shell.run("bundle install")
end
