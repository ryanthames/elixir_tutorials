defmodule WordClouds.FileConcatenator do
  def concatenate(list_of_files) do
    List.foldl(list_of_files, "", &(&2 <> File.read!(&1)))
  end
end
