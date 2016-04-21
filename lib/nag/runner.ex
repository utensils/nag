defmodule Nag.Runner do
  require Logger

  @runners Application.get_env(:nag, :runners, [])

  def start(payload, runners \\ @runners) do
    Logger.info("starting #{length(runners)} runners")
    Enum.each(runners, &(Task.async(&1, :run, [payload])))
  end
end
