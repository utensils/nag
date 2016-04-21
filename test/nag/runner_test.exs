defmodule Nag.RunnerTest do
  use ExUnit.Case
  use Plug.Test

  import ExUnit.CaptureLog

  alias Nag.Runner

  test "starts the list of runners" do
    log = capture_log(fn ->
      Runner.start(%{})
      :timer.sleep(10)
    end)

    assert log =~ "starting 1 runners"
    assert log =~ "success"
  end
end
