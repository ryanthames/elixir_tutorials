defmodule FirestormWebWeb.PageController do
  use FirestormWebWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
