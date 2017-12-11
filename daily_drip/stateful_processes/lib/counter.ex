defmodule Counter do
  def start(initial_value) do
    {:ok, spawn(Counter, :loop, [initial_value])}
  end

  def loop(value) do
    receive do
      {from, ref, :get_value} ->
        send(from, {:ok, ref, value})
        loop(value)
      :increment ->
        loop(value + 1)
      :decrement ->
        loop(value - 1)
    end
  end

  def get_value(pid) do
    ref = make_ref()
    send(pid, {self(), ref, :get_value})
    receive do
      {:ok, ^ref, val} -> {:ok, val}
    end
  end

  def increment(pid) do
    send(pid, :increment)
    :ok
  end

  def decrement(pid) do
    send(pid, :decrement)
    :ok
  end
end