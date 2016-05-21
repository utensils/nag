defmodule Nag.Runners.ProntoTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias Nag.Runners.Pronto

  test "logs message on unknown payloads" do
    log = capture_log(fn ->
      Pronto.run(%{})
    end)

    assert log =~ "unsupported payload"
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

    assert log =~ "shell finished 0"
    assert log =~ ~s("PULL_REQUEST_ID=#{number}" -e "REPO=#{repo}" -e "WORKING_BRANCH=#{branch}" pronto)
  end
end


