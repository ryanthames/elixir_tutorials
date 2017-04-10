defmodule RssWatcher do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(RssWatcher.FeedWatcher, ["http://www.reddit.com/new.rss"])
      #worker(RssWatcher.FeedWatcher, ["http://theerlangelist.com/rss"])
    ]

    opts = [strategy: :one_for_one, name: RssWatcher.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
