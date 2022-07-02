defmodule LiveWebStoreWeb.PageController do
  use LiveWebStoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
