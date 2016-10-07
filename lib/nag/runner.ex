defmodule Nag.Runner do
  require Logger

  @runners Application.get_env(:nag, :runners, [])

  def run(%{"action" => action, "pull_request" => pull_request}, runners \\ @runners) do
    Logger.debug("Starting #{length(runners)} runner(s)")
    Enum.each(runners, &(Task.async(&1, :run, [payload])))
  end
end
