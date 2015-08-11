defmodule PhoenixWsProxy.ProxySocket do
  use Phoenix.Socket

  channel "proxy:*", PhoenixWsProxy.ProxyChannel

  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(info, socket) do
    IO.puts "Connection started for #{inspect info}"
    {:ok, socket}
  end

  def id(_socket), do: nil


end
