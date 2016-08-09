defmodule PhoenixWsProxy.ProxySocket do
  use PhoenixWsProxy.Web, :socket

  channel "proxy:*", PhoenixWsProxy.ProxyChannel

  transport :websocket, Phoenix.Transports.WebSocket, check_origin: false
  transport :longpoll, Phoenix.Transports.LongPoll, check_origin: false

  def connect(info, socket) do
    IO.puts "Connection started for #{inspect info}"
    {:ok, socket}
  end

  def id(_socket), do: nil


end
