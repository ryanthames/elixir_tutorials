defmodule RssWatcher.FeedWatcher do
  use GenServer

  def start_link(url) do
    GenServer.start_link(__MODULE__, [url], [])
  end

  def init(url) do
    send(self, :fetch)
    {:ok, {url, Timex.now}}
  end

  def handle_info(:fetch, state={url, last_time}) do
    {:ok, feed} = fetch_feed(url)
    IO.inspect feed
    :timer.send_after(1_000, :fetch)
    {:noreply, state}
  end

  defp fetch_feed(url) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url)
    {:ok, feed, _} = FeederEx.parse(body)
    {:ok, feed}
  end
end
