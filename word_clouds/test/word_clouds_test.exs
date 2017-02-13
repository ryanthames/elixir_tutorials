defmodule WordCloudsTest do
  use ExUnit.Case
  doctest WordClouds

  alias WordClouds.WordCounter
  alias WordClouds.WordleNetFormatter
  alias WordClouds.FileConcatenator

  @example_text """
  foo foo bar baz baz whee foo
  """

  @example_text_wordcount [
    {"bar", 1},
    {"baz", 2},
    {"foo", 3},
    {"whee", 1}
  ] |> Enum.into(Map.new)

  @example_wordlenet_text """
  bar:1
  baz:2
  foo:3
  whee:1
  """ |> String.trim

  test "getting the word counts out of a corpus" do
    assert @example_text_wordcount == WordCounter.count(@example_text)
  end

  test "creating a wordle.net output string from a word count" do
    assert @example_wordlenet_text == WordleNetFormatter.output(@example_text_wordcount)
  end

  test "concatenating files together" do
    base_path = "test/tmp_files"
    File.mkdir_p(base_path)
    first_file_path = base_path <> "/1.txt"
    second_file_path = base_path <> "/2.txt"
    File.write!(first_file_path, @example_text)
    File.write!(second_file_path, @example_text)
    assert @example_text <> @example_text == FileConcatenator.concatenate([first_file_path, second_file_path])
  end
end
