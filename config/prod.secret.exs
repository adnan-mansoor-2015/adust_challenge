use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :adjust_server, AdjustServerWeb.Endpoint,
  secret_key_base: "uLMvhJ2x8mDX520RpFgBClhNZ8Yl26DSBWqib/MOMhzvuESUkv7pjfAT70FF/f/s"

# Configure your database
config :adjust_server, AdjustServer.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "adjust_server_prod",
  pool_size: 15
