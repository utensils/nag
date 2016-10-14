use Mix.Config

config :nag,
  runners: [Nag.Runners.Pronto],
  shell: Nag.Shell.Porcelain,
  github_token: "${GITHUB_ACCESS_TOKEN}"

config :logger,
  backends: [:console],
  level: :debug

import_config "#{Mix.env}.exs"
