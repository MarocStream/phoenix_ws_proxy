use Mix.Config

config :phoenix_ws_proxy,
  # Proxy will wait `sleep_factor` number of times as the speed of the request
  #   For example, 1 means wait equal to the request time, 0.5 means wait half
  #   the request time. Increase this number if your server is getting overloaded.
  sleep_factor:  1,
  # Proxy attempts not to DOS the server by waiting a minimum number of milliseconds.
  #   Increase this number if your server load spikes up and down.
  minimum_sleep: 2500,
  # Base URL to use for making requests to prevent making requests off site
  base_url:      "http://www.example.com/",
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

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
config :phoenix_ws_proxy, PhoenixWsProxy.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "example.com"],
  cache_static_manifest: "priv/static/manifest.json"

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section:
#
#  config:phoenix_ws_proxy, PhoenixWsProxy.Endpoint,
#    ...
#    https: [port: 443,
#            keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#            certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

# Do not print debug messages in production
config :logger, level: :info

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :phoenix_ws_proxy, PhoenixWsProxy.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately.
import_config "prod.secret.exs"
