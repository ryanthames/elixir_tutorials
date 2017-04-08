defmodule Upcaser do
  def start do
    pid = spawn(Upcaser, :loop, [])
    {:ok, pid}
  end

  def loop do
    receive do
      {from, ref, {:upcase, str}} -> send(from, {:ok, ref, String.upcase(str)})
    end

    loop
  end

  def upcase(server_pid, str) do
    ref = make_ref()
    send(server_pid, {self(), ref, {:upcase, str}})

    receive do
      {:ok, ^ref, str} -> {:ok, str}
    end
  end
end
