defmodule PhoenixWsProxy.Http do
  require Logger
  
  def get(url, headers \\ %{}) do
    :timer.tc fn ->
      case HTTPoison.get(url, headers) do
        {:ok, %HTTPoison.Response{status_code: code, body: body}} when code in [200, 301, 302] ->
          parse(body)
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          %{error: "Not found: #{url}"}
        # Rails closes the connection after returning the data... :hackney
        # doesn't like this and returns an error instead... the data is right
        # there but it thinks something went wrong...
        {:error, %HTTPoison.Error{reason: {:closed, body}}} ->
          parse(body)
        {:error, %HTTPoison.Error{reason: reason}} ->
          %{error: inspect(reason)}
      end
    end
  end

  def parse(body) do
    case Poison.Parser.parse(body) do
      {:ok, body} when is_map(body) ->
        body
      {:error, {:invalid, "<"}}     -> # HTML
        %{html: body}
      {:error, {reason, message}}   ->
        Logger.debug "Unable to parse as JSON: #{inspect reason} #{message}"
        %{text: body}
      {:error, :invalid} ->
        %{text: body}
    end
  end

end
