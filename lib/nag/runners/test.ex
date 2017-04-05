defmodule Nag.Runners.Test do
  @moduledoc """
  A runner for use in tests
  """

  require Logger

  def run(_), do: Logger.info("success")
end
