use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :link_extractor_web, LinkExtractorWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :link_extractor_web, LinkExtractorWeb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "link_extractor_web_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
