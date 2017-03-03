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
      ],
      mod: {Fly, []}
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:porcelain, "~> 2.0.3"},
      {:plug, "~> 1.3.0"},
      {:tesla, "~> 0.5.0"},
      {:hackney, "~> 1.6.3"},
    ]
  end
end
