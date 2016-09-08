defmodule Nag do
  use Application

  @cowboy_opts [ip: {0, 0, 0, 0}, port: 4000]
  @file_permission 111
  @repo_storage "./repos"
  @script "./scripts/pronto.sh"

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
    {:ok, _pid} = Plug.Adapters.Cowboy.http(Nag.Router, @cowboy_opts)
  end

  defp pretty_ip, do: @cowboy_opts[:ip] |> Tuple.to_list |> Enum.join(".")

  defp print_server_location do
    IO.puts "Nag online at #{pretty_ip}:#{@cowboy_opts[:port]}"
  end

  defp setup do
    chmod_script
    create_dir
    install_gems
  end

  defp chmod_script, do: File.chmod(@script, @file_permission)
  defp create_dir, do: File.mkdir(@repo_storage)
  defp install_gems, do: Porcelain.shell("bundle install")
end
