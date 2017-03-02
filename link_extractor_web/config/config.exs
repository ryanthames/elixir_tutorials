# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :link_extractor_web,
  ecto_repos: [LinkExtractorWeb.Repo]

# Configures the endpoint
config :link_extractor_web, LinkExtractorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NgubYADCPNmPO976fD1cvOPGS5NX27hrcZAJnDZYT70yEcD+3f5KwDEXgDYxsDmW",
  render_errors: [view: LinkExtractorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LinkExtractorWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
