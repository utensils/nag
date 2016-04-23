use Mix.Config

config :nag,
  runners: [Nag.Runners.Pronto],
  shell: Nag.Shell.Porcelain

import_config "#{Mix.env}.exs"
