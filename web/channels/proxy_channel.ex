defmodule PhoenixWsProxy.ProxyChannel do
  use PhoenixWsProxy.Web, :channel

  @data_update "data:update"

  def join(url, %{}, socket), do: join(url, nil, socket)
  def join(url, encrypted_session_id, socket) do
    base_url = Application.get_env(:phoenix_ws_proxy, :base_url, "http://localhost:3000/")
    socket = Socket.assign(socket, :url, Path.join(base_url, url))
      |> Socket.assign(:headers, setup_headers(base_url, encrypted_session_id))
      |> setup
    {:ok, socket}
  end

  defp setup_headers(_base_url, nil), do: %{}
  defp setup_headers(base_url, encrypted) do
    authorize_url = Application.get_env(:phoenix_ws_proxy, :authorize_url) || raise "Please supply the :authorize_url in your config.exs"
    encrypted_param = Application.get_env(:phoenix_ws_proxy, :encrypted_param) || raise "Please supply the :encrypted_param in your config.exs"
    full_url = Regex.replace ~r/#{encrypted_param}/, Path.join(base_url, authorize_url), encrypted
    {_, data} = get(full_url)
    path = Application.get_env(:phoenix_ws_proxy, :session_id_path) || raise "Please supply the :session_id_path in your config.exs"
    name = Application.get_env(:phoenix_ws_proxy, :session_id_key) || raise "Please supply the :session_id_key in your config.exs"
    %{"Cookie" => "#{name}=#{get_in(data, path)}"}
  end

  defp setup(socket) do
    socket = %{ socket | authorized: true, joined: true}
    pid = spawn_link fn -> poll(socket) end
    socket
  end

  defp poll(socket, timeout \\ 0) do
    sleep_factor = Application.get_env(:phoenix_ws_proxy, :sleep_factor, 1)
    min_sleep = Application.get_env(:phoenix_ws_proxy, :minimum_sleep, 100)
    if Process.alive?(socket.transport_pid) do
      :timer.sleep(timeout)

      {time, data} = get(socket.assigns[:url], socket.assigns[:headers])

      if data == socket.assigns[:data] do
        Logger.debug "#{inspect self} Completed #{socket.assigns[:url]} in #{inspect (time / 1000)}ms"
      else
        Logger.debug "#{inspect self} Data has changed"
        push(socket, @data_update, data)
        socket = Phoenix.Socket.assign(socket, :data, data)
      end
      sleep_time = trunc(time * sleep_factor / 1000)
      sleep_time = case sleep_time do
                     t when t > min_sleep -> t
                     _                    -> min_sleep
                   end
      Logger.debug "#{inspect self} Sleeping #{inspect (sleep_time / 1000)} sec"
      poll(socket, sleep_time)
    end
  end

end
