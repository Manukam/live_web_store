defmodule LiveWebStore.Features.Features do

  import Ecto.Query, warn: false
  alias LiveWebStore.Repo
  alias LiveWebStore.Products


  def list_products(params) do
    search_term = get_in(params, ["query"])

    LiveWebStore.Products
    |> LiveWebStore.Products.list_products(search_term)
    |> Repo.all()
  end


end
