defmodule ThyWorker do
  def start_link do
    spawn(fn -> await end)
  end

  def await do
    receive do
      :stop -> :ok
      msg ->
        IO.inspect msg
        await
    end
  end
end
