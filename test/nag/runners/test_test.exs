defmodule Nag.Runners.TestTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias Nag.Runners.Test

  test "logs success" do
    log = capture_log(fn ->
      Test.run(%{})
    end)

    assert log =~ "success"
  end
end

