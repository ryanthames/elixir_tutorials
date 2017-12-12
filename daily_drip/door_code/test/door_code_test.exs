defmodule DoorCodeTest do
  use ExUnit.Case
  doctest DoorCode

  @code [1, 2, 3]
  @open_time 100

  test "happy path" do
    {:ok, door} = Door.start_link({@code, @code, @open_time})
    assert Door.get_state(door) == :locked
    door |> Door.press(1)
    assert Door.get_state(door) == :locked
    door |> Door.press(2)
    assert Door.get_state(door) == :locked
    door |> Door.press(3)
    assert Door.get_state(door) == :open
    :timer.sleep(@open_time)
    assert Door.get_state(door) == :locked
  end

  test "pressing buttons after unlock" do
    {:ok, door} = Door.start_link({@code, @code, @open_time})
    assert Door.get_state(door) == :locked
    door |> Door.press(1)
    assert Door.get_state(door) == :locked
    door |> Door.press(2)
    assert Door.get_state(door) == :locked
    door |> Door.press(3)
    assert Door.get_state(door) == :open
    door |> Door.press(5)
    :timer.sleep(@open_time)
    assert Door.get_state(door) == :locked
  end
end
