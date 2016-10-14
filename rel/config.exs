use Mix.Releases.Config,
    default_release: :default,
    default_environment: :dev

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"KhR|t`X<$]XHx%uXJEkP3E,psDpd}qWtBb}/E.4b>-A;0euB{{!+>~F]?:I37VI:"
end

environment :prod do
  set include_erts: false
  set include_src: false
  set cookie: :"KhR|t`X<$]XHx%uXJEkP3E,psDpd}qWtBb}/E.4b>-A;0euB{{!+>~F]?:I37VI:"
end

release :nag do
  set version: current_version(:nag)
  set overlays: [
    {:mkdir, "scripts"},
    {:copy, "scripts/pronto.sh", "scripts/pronto.sh"},
    {:copy, "Gemfile", "Gemfile"}
  ]
end
