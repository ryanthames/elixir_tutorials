defmodule WordClouds.WordCounter do
  def count(text) do
    words = String.split(text)
    count(words, Map.new)
  end

  def count([], acc), do: acc
  def count([next|rest], acc) do
    new_acc = Map.update(acc, next, 1, &(&1 + 1))
    count(rest, new_acc)
  end
end
