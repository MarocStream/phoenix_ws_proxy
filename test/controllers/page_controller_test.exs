defmodule PhoenixWsProxy.PageControllerTest do
  use PhoenixWsProxy.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert conn.resp_body =~ "Auth Token"
    assert conn.resp_body =~ "URL"
    assert conn.resp_body =~ "Connect"
  end
end
