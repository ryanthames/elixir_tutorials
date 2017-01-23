defprotocol Odd do
  @doc "Returns true if data is considered odd"
  def odd?(data)
end

defimpl Odd, for: Integer do
  require Integer

  def odd?(data) do
    Integer.is_odd(data)
  end
end

defimpl Odd, for: Float do
  def odd?(data) do
    Odd.odd?(Float.floor(data))
 end
end

defmodule OddProtocolTest do
  use ExUnit.Case
  doctest OddProtocol

  test "integers know if they are odd" do
    assert Odd.odd?(1)
    refute Odd.odd?(2)
  end

  test "floats are odd if their floor is" do
    assert Odd.odd?(1.1)
    assert Odd.odd?(1.9)
    refute Odd.odd?(2.2)
  end
end
