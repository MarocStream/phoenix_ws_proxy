defmodule PhoenixWsProxy.ProxySocket do
  use Phoenix.Socket

  channel "proxy:*", PhoenixWsProxy.ProxyChannel

  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(_info, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil


end
