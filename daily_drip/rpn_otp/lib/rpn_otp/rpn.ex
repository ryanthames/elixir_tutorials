defmodule Rpn do
  use GenServer

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def peek(pid) do
    {:ok, state} = GenServer.call(pid, :peek)
    state
  end

  def push(pid, val) do
    GenServer.cast(pid, {:push, val})
  end

  ## Server API
  def handle_call(:peek, _from, state) do
    {:reply, {:ok, state}, state}
  end

  def handle_cast({:push, :+}, state) do
    [second|[first|rest]] = state
    {:noreply, [first + second | rest]}
  end

  def handle_cast({:push, :-}, state) do
    [second|[first|rest]] = state
    {:noreply, [first - second | rest]}
  end

  def handle_cast({:push, :x}, state) do
    [second|[first|rest]] = state
    {:noreply, [first * second | rest]}
  end

  def handle_cast({:push, val}, state) do
    {:noreply, [val|state]}
  end
end
