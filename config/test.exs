use Mix.Config

config :phoenix_ws_proxy,
  # Proxy will wait `sleep_factor` number of times as the speed of the request
  #   For example, 1 means wait equal to the request time, 0.5 means wait half
  #   the request time. Increase this number if your server is getting overloaded.
  sleep_factor:  1,
  # Proxy attempts not to DOS the server by waiting a minimum number of milliseconds.
  #   Increase this number if your server load spikes up and down.
  minimum_sleep: 1,
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

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_ws_proxy, PhoenixWsProxy.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phoenix_ws_proxy, PhoenixWsProxy.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "phoenix_ws_proxy_test",
  size: 1,
  max_overflow: false
