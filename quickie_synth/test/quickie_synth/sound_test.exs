defmodule QuickieSynth.SoundTest do
  use ExUnit.Case
  alias QuickieSynth.Sound

  test "outputs the appropriate command to play a C note" do
    assert Sound.command("C") == "play -qn synth 2 pluck C"
  end
end
