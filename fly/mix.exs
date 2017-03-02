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
        :porcelain
      ],
      mod: {Fly, []}
    ]
  end

  defp deps do
    [
      {:porcelain, "~> 2.0.3"}
    ]
  end
end
