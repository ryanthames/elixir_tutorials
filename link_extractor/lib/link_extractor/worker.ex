defmodule LinkExtractor.Worker do
  use GenServer
  alias LinkExtractor.Link

  @url_regex ~r(https?://[^ $\n]*)

  def start_link(_options) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def handle_message(server, message) do
    GenServer.call(server, {:handle_message, message})
  end

  ## Server callbacks
  def init(_options) do
    {:ok, []}
  end

  def handle_call({:handle_message, message}, _from, state) do
    extract_links(message)
    |> Enum.map(fn(link) ->
      Agent.update(:collector, &([link|&1]))
    end)

    {:reply, :ok, state}
  end

  def extract_links(message) do
    Regex.scan(@url_regex, message)
    |> Enum.map(&hd/1)
    |> Enum.map(&(%Link{url: &1}))
    |> Enum.map(&add_title/1)
  end

  defp add_title(link=%Link{url: url}) do
    title_pattern = ~r"<title>([^<]*)</title>"
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url)
    title = Regex.run(title_pattern, body) |> Enum.at(1)
    %Link{link | title: title}
  end
end
