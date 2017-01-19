defmodule DigraphMaps.MapsTest do
  use ExUnit.Case
  alias DigraphMaps.Map

  test "Creating a map" do
    map = Map.new
    assert %Map{} = map
    assert {:digraph, _, _, _, _} = map.digraph
  end
end
