# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveWebStore.Repo.insert!(%LiveWebStore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LiveWebStore.Products.Product
alias LiveWebStore.Repo

File.stream!("priv/repo/products.csv")
|> Stream.drop(1)
|> CSV.decode(headers: [:id, :sku, :units_sold, :unit_price, :title, :average_discount])
|> Enum.each(fn
  {:ok, map} ->
    Product.changeset(
      %Product{},
      %{
        id: map[:id],
        sku: map[:sku],
        title: map[:title],
        units_sold: map[:units_sold],
        unit_price: map[:unit_price],
        average_discount: map[:average_discount]
      }
    )
    |> Repo.insert!()

  other ->
    IO.inspect(other, label: "Unexpected")
end)
