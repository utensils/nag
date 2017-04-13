defmodule Nag.Mixfile do
  use Mix.Project

  def project do
    [app: :nag,
      version: "1.1.0",
      elixir: "~> 1.4",
      package: package(),
      start_permanent: Mix.env == :prod,
      deps: deps()]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Nag, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:logger_file_backend, ">= 0.0.0"},
      {:plug, "~> 1.1"},
      {:poison, "~> 2.1"},
      {:porcelain, "~> 2.0"},

      # Deployments
      {:distillery, ">= 0.0.0"},

      # Dev & Test
      {:credo, "~> 0.7"}
    ]
  end

  defp package do
    [maintainers: ["Sean Callan"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/wombatsecurity/nag"},
      files: ~w(lib scripts mix.exs Gemfile CHANGELOG.md LICENSE.md README.md)]
  end
end
