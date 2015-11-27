use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :phoenix_ws_proxy, PhoenixWsProxy.Endpoint,
  secret_key_base: "qM8GYy0mKaDwgGmPKuEHEsVkTtU8G/rY4QnCAgAegcM1wOrUUIEDy39sJXiSsBsN"

# Configure your database
# config :phoenix_ws_proxy, PhoenixWsProxy.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "phoenix_ws_proxy_prod"
