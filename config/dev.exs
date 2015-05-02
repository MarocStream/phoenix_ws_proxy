use Mix.Config

config :phoenix_ws_proxy,
  # Proxy will wait `sleep_factor` number of times as the speed of the request
  #   For example, 1 means wait equal to the request time, 0.5 means wait half
  #   the request time. Increase this number if your server is getting overloaded.
  sleep_factor:  1,
  # Proxy attempts not to DOS the server by waiting a minimum number of milliseconds.
  #   Increase this number if your server load spikes up and down.
  minimum_sleep: 1000,
  # Base URL to use for making requests to prevent making requests off site
  base_url:      "http://localhost:3000/",
  # The path from `base_url` in which the polled server will respond with the decrypted
  #   session id. Notice that `:token` is the same as the `encrypted_param` setting.
  authorize_url: "/sessions/reauth/:token",
  # The value inside of authorize_url to replace with the encrypted key.
  encrypted_param: ":token",
  # From the response JSON data in the `authorize_url` path, where is the decrypted
  #   session id. Should be a list of keys to reach the data.
  session_id_path: ["session_id"],
  # The cookie name for where to put the `session_id_path` data when the server is polled
  session_id_key: :_my_app_session_id

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :phoenix_ws_proxy, PhoenixWsProxy.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]]

# Watch static and templates for browser reloading.
config :phoenix_ws_proxy, PhoenixWsProxy.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# # Configure your database
# config :phoenix_ws_proxy, PhoenixWsProxy.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "phoenix_ws_proxy_dev"
