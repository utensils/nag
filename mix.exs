defmodule Nag.Mixfile do
  use Mix.Project

  def project do
    [app: :nag,
     version: "1.0.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:cowboy, :logger, :plug, :porcelain],
      mod: {Nag, []}]
  end

  defp deps do
    [{:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.1"},
     {:poison, "~> 2.1"},
     {:porcelain, "~> 2.0"}]
  end
end
