defmodule PorcelainPlaygroundTest do
  use ExUnit.Case
  doctest PorcelainPlayground

  @test_files_path "test/files/elixir_port"

  setup do
    File.mkdir_p(@test_files_path)

    on_exit fn ->
      File.rm_rf(@test_files_path)
    end

    :ok
  end

  test "evaluating and giving a response" do
    File.mkdir_p(@test_files_path <> "/1")
    File.touch(@test_files_path <> "/1/first")
    File.touch(@test_files_path <> "/1/second")
    expected_output = "first\nsecond\n"
    assert expected_output == Porcelain.shell("ls #{@test_files_path}/1").out
    assert expected_output == Porcelain.exec("ls", ["#{@test_files_path}/1"]).out
  end

  test "managing pipelines" do
    opus = """
    poppycock
    garnish
    rutabaga
    pipsqueak
    """

    sorted = """
    garnish
    pipsqueak
    poppycock
    rutabaga
    """

    File.mkdir_p(@test_files_path <> "/2")
    text_file = @test_files_path <> "/2/text_file"
    output_file = @test_files_path <> "/2/output_file"
    File.write!(text_file, opus)

    Porcelain.exec("sort", [], in: {:path, text_file}, out: {:append, output_file})
    assert sorted == File.read!(output_file)
  end
end
