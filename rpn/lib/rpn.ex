defmodule Rpn do
  use GenServer

  ## Client
  def start do
    GenServer.start_link(__MODULE__, [])
  end

  def peek(pid) do
    GenServer.call(pid, :peek)
  end

  def push(pid, :+) do
    GenServer.cast(pid, :add)
  end

  def push(pid, :-) do
    GenServer.cast(pid, :sub)
  end

  def push(pid, :x) do
    GenServer.cast(pid, :mult)
  end

  def push(pid, value) do
    GenServer.cast(pid, {:push, value})
  end

  ## Callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call(:peek, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, value}, state) do
    {:noreply, [value] ++ state}
  end

  def handle_cast(:add, state) do
    [x|[y|tail]] = state
    {:noreply, [y+x] ++ tail}
  end

  def handle_cast(:sub, state) do
    [x|[y|tail]] = state
    {:noreply, [y-x] ++ tail}
  end

  def handle_cast(:mult, state) do
    [x|[y|tail]] = state
    {:noreply, [y*x] ++ tail}
  end
end
