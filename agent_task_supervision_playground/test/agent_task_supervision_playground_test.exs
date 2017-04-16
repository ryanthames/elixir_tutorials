defmodule AgentTaskSupervisionPlaygroundTest do
  use ExUnit.Case
  doctest AgentTaskSupervisionPlayground

  alias AgentTaskSupervisionPlayground.Bucket

  test "tasks that outlive their spawner" do
    pid = self()
    spawn(fn() ->
      Task.Supervisor.start_child(OurSupervisor, fn() ->
        :timer.sleep 50
        send(pid, :sup)
      end)
      Process.exit(self(), :kill)
    end)

    :timer.sleep 60
    assert_receive :sup
  end

  test "working with an agent" do
    Bucket.push(OurBucket, :foo)
    assert :foo == Bucket.head(OurBucket)
  end
end
