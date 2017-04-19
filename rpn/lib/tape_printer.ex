defmodule Rpn.TapePrinter do
  use GenServer
  @name TapePrinter

  ## Client
  def start_link do
    GenServer.start_link(__MODULE__, [], [name: @name])
  end

  def print(term) do
    GenServer.cast(@name, {:print, term})
  end

  ## Server
  def init do
    {:ok, []}
  end

  def handle_cast({:print, term}, state) do
    IO.puts term
    {:noreply, [term | state]}
  end
end
