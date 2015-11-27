defmodule PhoenixWsProxy.Config do

  def base_url,        do: Application.get_env(:phoenix_ws_proxy, :base_url, "http://localhost:3000/")
  def authorize_url,   do: Application.get_env(:phoenix_ws_proxy, :authorize_url) || raise "Please supply the :authorize_url in your config.exs"
  def encrypted_param, do: Application.get_env(:phoenix_ws_proxy, :encrypted_param) || raise "Please supply the :encrypted_param in your config.exs"
  def session_id_path, do: Application.get_env(:phoenix_ws_proxy, :session_id_path) || raise "Please supply the :session_id_path in your config.exs"
  def session_id_name, do: Application.get_env(:phoenix_ws_proxy, :session_id_key) || raise "Please supply the :session_id_key in your config.exs"
  def sleep_factor,    do: Application.get_env(:phoenix_ws_proxy, :sleep_factor, 1)
  def min_sleep,       do: Application.get_env(:phoenix_ws_proxy, :minimum_sleep, 100)

end
