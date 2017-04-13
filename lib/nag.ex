defmodule Nag do
  @moduledoc """
  Nag OTP application
  """

  use Application

  require Logger

  alias Nag.{Router, Shell}
  alias Plug.Adapters.Cowboy

  @file_permission 0o755
  @script_path Application.get_env(:nag, :script_path)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    setup()

    children = [
      supervisor(Task.Supervisor, [[name: :tasks_sup]]),
      Cowboy.child_spec(:http, Router, [], [port: 4000]),
    ]

    opts = [strategy: :one_for_one, name: Nag.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp setup do
    chmod_script()
    install_gems()
  end

  defp chmod_script,
    do: File.chmod(@script_path, @file_permission)

  defp install_gems,
    do: Shell.run("bundle install")
end
