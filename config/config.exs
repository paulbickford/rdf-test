# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rdf_test,
  ecto_repos: [RdfTest.Repo]

# Configures the endpoint
config :rdf_test, RdfTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uZLkPUu+SdnbMhSoSwpJOY+c/CDNqbRBJWeF129JTx9JGII5IsG/I4UhRfNHIq1P",
  render_errors: [view: RdfTestWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: RdfTest.PubSub,
  live_view: [signing_salt: "mO80ZcTs"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
