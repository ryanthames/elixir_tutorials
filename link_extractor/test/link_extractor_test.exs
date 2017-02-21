defmodule LinkExtractorTest do
  use ExUnit.Case
  doctest LinkExtractor

  alias LinkExtractor.Link

  @message """
  Augie,

  Ctrl-p: https://github.com/kien/ctrlp.vim

  That is probably my absolute favorite vim plugin
  """

  @expected_link %Link{
    url: "https://github.com/kien/ctrlp.vim",
    title: "GitHub - kien/ctrlp.vim: Fuzzy file, buffer, mru, tag, etc finder."
  }

  test "when text is injected into the system, those links are stored" do
    LinkExtractor.inject(@message)
    :timer.sleep(3000)
    assert LinkExtractor.get_links == [@expected_link]
  end
end
