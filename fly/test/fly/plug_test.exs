defmodule Fly.PlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @root_dir File.cwd!
  @test_dir Path.join(@root_dir, "test")
  @fixtures_dir Path.join(@test_dir, "fixtures")

  @opts Fly.Plug.init([])
  @fly_jgp_url "https://raw.githubusercontent.com/dailydrip/fly/after_episode_283/test/fixtures/fly.jpg"

  test "gets static text" do
    conn = 
      :get
      |> conn("/static?url=#{@fly_jgp_url}")
      |> Fly.Plug.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == "giggity"
  end

  test "handles pngify" do
    conn = 
      :get
      |> conn("/pngify?url=#{@fly_jgp_url}")
      |> Fly.Plug.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == read_fixture("fly.png")
  end

  test "handles resize" do
    conn = 
      :get
      |> conn("/resize=#{@fly_jgp_url}&size=100x")
      |> Fly.Plug.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == read_fixture("fly_resize_100x.jpg")
  end

  defp read_fixture(filename) do
    @fixtures_dir
    |> Path.join(filename)
    |> File.read!
  end
end
