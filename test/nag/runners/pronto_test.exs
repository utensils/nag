defmodule Nag.Runners.ProntoTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias Nag.Runners.Pronto

  test "logs message on unknown payloads" do
    log = capture_log(fn ->
      Pronto.run(%{})
    end)

    assert log =~ "Unsupported payload"
  end

  test "logs success on known messages" do
    branch = "test_branch"
    repo = "test/repo"
    number = 1
    payload = %{"action" => "opened",
                "pull_request" => %{
                  "head" => %{"ref" => branch, "repo" => %{"full_name" => repo}},
                  "number" => number,
                  "state" => "open"
                }}

    log = capture_log(fn ->
      Pronto.run(payload)
    end)

    assert log =~ "Shell finished 0"
    assert log =~ "REPO=test/repo WORKING_BRANCH=test_branch"
    assert log =~ "scripts/pronto.sh"
  end
end
