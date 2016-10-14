defmodule Nag.RunnerTest do
  use ExUnit.Case
  use Plug.Test

  import ExUnit.CaptureLog

  alias Nag.Runner

  test "starts the list of runners" do
    log = capture_log(fn ->
      Runner.run(%{})
      :timer.sleep(10)
    end)

    assert log =~ "Starting 1 runner(s)"
    assert log =~ "success"
  end
end
