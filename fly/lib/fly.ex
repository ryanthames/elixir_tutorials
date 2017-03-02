defmodule Fly do
  @otp_app :fly
  use Application
  require Logger

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
    ]

    opts = [strategy: :one_for_one, name: Fly.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec run(atom(), binary(), map()) :: binary()
  def run(config_atom, input, options \\ %{}) 
      when is_atom(config_atom) 
      and is_binary(input) 
      and is_map(options) do
    case get_module_and_configuration(config_atom) do
      {mod, config} ->
        apply(mod, :call, [input, Map.merge(config, options)])
      _ ->
        Logger.error """
        No such Fly configuration: #{config_atom}. Have you configured it? It should 
        look like:
          config :fly, :workers,
          %{
          #{config_atom}: {Fly.Worker.SomeModule, %{some: :config}}
          }

        You can look up the configuration options for the module you're trying to use in
        its documentation.
        """
    end
  end

  @spec get_module_and_configuration(atom()) :: {atom(), map()}
  defp get_module_and_configuration(config_atom) do
    @otp_app
    |> Application.get_env(:workers)
    |> Map.get(config_atom)
  end
end
