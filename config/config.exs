use Mix.Config

config :nag,
  github_token: "${GITHUB_ACCESS_TOKEN}",
  runners: [Nag.Runners.Pronto],
  script_path: "scripts/pronto.sh",
  shell: Nag.Shell.Porcelain

config :logger,
  backends: [:console],
  level: :debug

import_config "#{Mix.env}.exs"
