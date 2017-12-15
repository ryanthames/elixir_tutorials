defmodule RpnOtp.TapeModule do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def print(pid, msg) do
    GenServer.cast(pid, {:write, msg})
  end

  ## Server API
  def handle_cast({:write, msg}, state) do
    {:ok, file} = File.open("output.txt", [:write])
    IO.write("#{msg}\n")
  end
end
