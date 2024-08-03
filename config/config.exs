# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :command_center,
  ecto_repos: [CommandCenter.Repo],
  event_stores: [EventDriven.EventStore],
  generators: [timestamp_type: :utc_datetime]

config :command_center, EventDriven.Application,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: EventDriven.EventStore
  ],
  pubsub: :local,
  registry: :local

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

# config :commanded_ecto_projections,
#  repo: CommandCenter.Repo

# Configures the endpoint
config :command_center, CommandCenterWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: CommandCenterWeb.ErrorHTML, json: CommandCenterWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: CommandCenter.PubSub,
  live_view: [signing_salt: "87TnTtY0"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :command_center, CommandCenter.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  command_center: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  command_center: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
