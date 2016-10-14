defmodule Nag.Shell do

  require Logger

  @shell Application.get_env(:nag, :shell)

  def run(cmd) do
    Logger.debug("Running shell cmd: #{cmd}")

    @shell
    |> apply(:shell, [cmd])
    |> log_result
  end

  defp log_result(%{out: out, status: status} = result) do
    Logger.debug("Shell finished #{Integer.to_string(status)}")
    Logger.debug(out)

    result
  end
end
