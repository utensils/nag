use Mix.Config

config :nag,
  runners: [Nag.Runners.Pronto],
  shell: Nag.Shell.Porcelain

config :logger,
  backends: [:console],
  level: :info

import_config "#{Mix.env}.exs"
