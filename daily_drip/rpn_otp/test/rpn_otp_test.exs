defmodule RpnOtpTest do
  use ExUnit.Case
  doctest RpnOtp

  test "starts with an empty stack" do
    assert Rpn.peek(Rpn) == []
  end

  test "pushing onto the stack" do
    Rpn.push(Rpn, 5)
    assert Rpn.peek(Rpn) == [5]
    Rpn.push(Rpn, 1)
    assert Rpn.peek(Rpn) == [1, 5]
  end

  test "adding" do
    Rpn.push(Rpn, 5)
    Rpn.push(Rpn, 1)
    Rpn.push(Rpn, :+)
    assert Rpn.peek(Rpn) == [6]
  end

  test "subtracting" do
    Rpn.push(Rpn, 5)
    Rpn.push(Rpn, 1)
    Rpn.push(Rpn, :-)
    assert Rpn.peek(Rpn) == [4]
  end

  test "multiplying" do
    Rpn.push(Rpn, 5)
    Rpn.push(Rpn, 2)
    Rpn.push(Rpn, :x)
    assert Rpn.peek(Rpn) == [10]
  end

  test "wikipedia example" do
    Rpn.push(Rpn, 5)
    Rpn.push(Rpn, 1)
    Rpn.push(Rpn, 2)
    Rpn.push(Rpn, :+)
    Rpn.push(Rpn, 4)
    Rpn.push(Rpn, :x)
    Rpn.push(Rpn, :+)
    Rpn.push(Rpn, 3)
    Rpn.push(Rpn, :-)
    assert Rpn.peek(Rpn) == [14]
  end

  test "process restarts after being killed" do
    Rpn.push(Rpn, 0)
    Rpn.push(Rpn, 5)
  end
end
