defmodule LinkExtractorWeb.PageController do
  use LinkExtractorWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
