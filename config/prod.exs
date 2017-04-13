use Mix.Config

config :logger,
  backends: [{LoggerFileBackend, :file_log}, :console],
  handle_otp_reports: true,
  handle_sasl_reports: true,
  level: :debug

config :logger, :file_log,
  path: "/srv/log/app.log",
  level: :debug
