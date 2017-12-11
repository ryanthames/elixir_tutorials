defmodule OtpPlayground.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(OtpPlayground.FridgeServer, [[name: Fridge]])
    ]

    opts = [strategy: :one_for_one, name: OtpPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
