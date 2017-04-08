defmodule UpcaserTest do
  use ExUnit.Case
  doctest Upcaser

  test "starting the service" do
    assert {:ok, upcaser_pid} = Upcaser.start
    assert is_pid(upcaser_pid)
  end

  test "sending a string to be upcased" do
    {:ok, upcaser_pid} = Upcaser.start
    assert {:ok, "FOO"} = Upcaser.upcase(upcaser_pid, "foo")
  end
end
