use Mix.Config

config :fly, :workers,
  %{
    static: {Fly.Worker.StaticText, %{}},
    pngify: {Fly.Worker.Pngify, %{}},
    resize: {Fly.Worker.Resize, %{}},
  }
