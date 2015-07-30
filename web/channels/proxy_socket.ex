defmodule PhoenixWsProxy.ProxySocket do
  use Phoenix.Socket

  channel "proxy:*", PhoenixWsProxy.ProxyChannel

  def connect(_info, socket) do
    IO.puts "Connecting to PROXY SOCKET"
    {:ok, socket}
  end

  def id(_socket), do: "#{__MODULE__}"


end
