defmodule PhoenixWsProxy.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_ws_proxy,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {PhoenixWsProxy, []},
     applications: [:phoenix, :cowboy, :logger, :httpoison]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.1.4"},
      {:phoenix_html, "~> 2.5.1"},
      {:httpoison, "~> 0.8.2"},
      {:cowboy, "~> 1.0"},
      {:exrm, "~> 1.0.3"},
      {:global, "~> 1.0.0"},
      # Dev
      {:phoenix_live_reload, "~> 1.0", only: :dev}
    ]
  end
end
