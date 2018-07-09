# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :adjust_server,
  ecto_repos: [AdjustServer.Repo]

# Configures the endpoint
config :adjust_server, AdjustServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "l9H89qZ1YOyKG1v2gw1nyvXe26aAocn1CrLMaAMGPkJ5Sdxti+cG+xx70Bkh4hAn",
  render_errors: [view: AdjustServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: AdjustServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
