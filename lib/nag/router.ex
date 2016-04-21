defmodule Nag.Router do
  require Logger

  use Plug.Router

  alias Nag.Runner
  alias Plug.Conn

  plug :match
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :dispatch

  get "/", do: render_json(conn, 200, %{msg: "nothing here to see, move along"})

  match _, do: render_json(conn, 404, %{error: "not found"})

  defp render_json(conn, status, map) do
    json = Poison.encode!(map)
    send_resp(conn, status, json)
  end
end
