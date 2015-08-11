defmodule PhoenixWsProxy.PageController do
  use PhoenixWsProxy.Web, :controller 

  def index(conn, _params) do
    render conn, "index.html"
  end
end
