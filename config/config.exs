# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :clarx,
  ecto_repos: [Clarx.Repo]

# Configures the repo
config :clarx, Clarx.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id],
  migration_timestamps: [type: :timestamptz]

# Configures the endpoint
config :clarx, ClarxWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: ClarxWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Clarx.PubSub,
  live_view: [signing_salt: "ErRyBIM/"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :clarx, Clarx.Mailer, adapter: Swoosh.Adapters.Local

# Configures the tzdata
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
