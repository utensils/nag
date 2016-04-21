defmodule Nag.RouterTest do
  use ExUnit.Case
  use Plug.Test

  alias Nag.Router

  @opts Router.init([])

  test "receive a message on index" do
    conn = :get
            |> conn("/", "")
            |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert json_response(conn)["msg"] =~ "nothing here to see,"
  end

  test "receive an error on 404" do
    conn = :get
            |> conn("/missing", "")
            |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
    assert json_response(conn)["error"] == "not found"
  end

  defp json_response(conn) do
    Poison.decode!(conn.resp_body)
  end
end
