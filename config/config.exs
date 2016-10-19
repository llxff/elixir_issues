use Mix.Config

config :logger, compile_time_purge_level: :info

config :issues, github_url: "https://api.github.com"
config :issues, columns: [
  %{ name: "#", size: 11, value: "id" },
  %{ name: "created_at", size: 22, value: "created_at"},
  %{ name: "title", size: 50, value: "title" }
]
