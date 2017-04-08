defmodule Fly.Mixfile do
  use Mix.Project

  def project do
    [app: :fly,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      applications: [
        :logger,
        :porcelain,
        :plug,
        :hackney,
        :lru_cache,
      ],
      mod: {Fly, []}
    ]
  end

  defp applications(:test) do
    applications(:prod) ++ [:dbg]
  end

  defp applications(:dev) do
    applications(:prod) ++ [:dbg]
  end

  defp applications(_) do
    [
      :logger,
      :porcelain,
      :plug,
      :hackney,
      :lru_cache,
    ]
  end

  defp deps do
    [
      {:porcelain, "~> 2.0.3"},
      {:plug, "~> 1.3.0"},
      {:tesla, "~> 0.5.0"},
      {:hackney, "~> 1.6.3"},
      {:lru_cache, "~> 0.1.1"},

      # dev and test dependencies
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:dbg, "~> 1.0", only: [:dev, :test]},
    ]
  end
end
