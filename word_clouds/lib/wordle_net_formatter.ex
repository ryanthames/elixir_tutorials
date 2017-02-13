defmodule WordClouds.WordleNetFormatter do
  def output(word_count_map) do
    list_of_frequencies(word_count_map)
    |> Enum.join("\n")
  end

  defp list_of_frequencies(word_count_map) do
    for {word, count} <- sorted_list(word_count_map), into: [], do: "#{word}:#{count}"
  end

  defp sorted_list(word_count_map) do
    Map.to_list(word_count_map) |> List.keysort(0)
  end
end
