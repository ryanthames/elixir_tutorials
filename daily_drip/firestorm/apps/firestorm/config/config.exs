# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :firestorm,
  namespace: Firestorm,
  ecto_repos: [Firestorm.Repo]

# Configures the endpoint
config :firestorm, FirestormWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MrOde3skQdgUN/y6ovgIqCFjcs7qBsd72mRKajUgwtAiY3Hle+6v8eJAvPj50lwu",
  render_errors: [view: FirestormWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Firestorm.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
