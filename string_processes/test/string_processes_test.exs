defmodule StringProcesses do
  def publish(message) do
    for pid <- :pg2.get_members(:string_processes) do
      send(pid, {self, message})
    end
  end

  def add_process(module) do
    :pg2.create(:string_processes)
    pid = apply(module, :start, [])
    :pg2.join(:string_processes, pid)
    pid
  end
end

defmodule StringProcesses.Process.Reverser do
  def start do
    spawn(__MODULE__, :await, [])
  end

  def await do
    receive do
      {pid, message} -> send(pid, {__MODULE__, String.reverse(message)})
    end
    await
  end
end

defmodule StringProcesses.Process.Uppercaser do
  def start do
    spawn(__MODULE__, :await, [])
  end

  def await do
    receive do
      {pid, message} -> send(pid, {__MODULE__, String.upcase(message)})
    end
    await
  end
end

defmodule StringProcessesTest do
  use ExUnit.Case
  doctest StringProcesses

  setup do
    on_exit fn ->
      :pg2.delete(:string_processes)
    end
  end

  test "if a reverser is in the group, receive string back reversed" do
    StringProcesses.add_process(StringProcesses.Process.Reverser)
    StringProcesses.publish("amirite?")
    assert_receive {StringProcesses.Process.Reverser, "?etirima"}
  end

  test "can add multiple processes" do
    StringProcesses.add_process(StringProcesses.Process.Reverser)
    StringProcesses.add_process(StringProcesses.Process.Uppercaser)
    StringProcesses.publish("amirite?")
    assert_receive {StringProcesses.Process.Reverser, "?etirima"}
    assert_receive {StringProcesses.Process.Uppercaser, "AMIRITE?"}
  end
end
