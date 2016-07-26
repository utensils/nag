defmodule Nag.Router do
  require Logger

  use Plug.Router

  alias Nag.Runner

  plug :match
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :dispatch

  get "/", do: render_json(conn, 200, %{msg: "nothing here to see, move along"})

  post "/webhook" do
    conn
    |> extract_payload
    |> run
    |> render_json(201, %{msg: "thank you"})
  end

  match _, do: render_json(conn, 404, %{error: "not found"})

  defp extract_payload(conn), do: {conn, conn.body_params}

  defp render_json(conn, status, map) do
    json = Poison.encode!(map)
    send_resp(conn, status, json)
  end

  defp run({conn, payload}) do
    Task.async(Runner, :start, [payload])
    conn
  end
end
