defmodule Nag.Runner do
  @moduledoc """
  Processes requests through a runner pipeline
  """

  require Logger

  @runners Application.get_env(:nag, :runners, [])

  def run(payload, runners \\ @runners) do
    Logger.debug("Starting #{length(runners)} runner(s)")
    Enum.each(runners, &(Task.async(&1, :run, [payload])))
  end
end
