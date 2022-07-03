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
    |> Enum.each(fn {:ok, map} ->
      Product.changeset(
        %Product{},
        %{id: map[:id],
        sku: map[:sku],
        title: map[:title],
        units_sold: map[:units_sold],
        unit_price: map[:unit_price],
        average_discount: map[:average_discount]
      }) |> Repo.insert!()
      other -> IO.inspect(other, label: "Unexpected") end)

# defmodule LiveWebStore.Seeds do

  # def store_it(row) do
  #   {:ok, result} = row

  #   %Product{
  #     id: result.id,
  #     sku: result.sku,
  #     title: result.title,
  #     units_sold: result.units_sold,
  #     unit_price: result.unit_price,
  #     average_discount: result.average_discount
  #   } |> Repo.insert!
  # end


    # |> File.stream!("priv/repo/products.csv")
    # |> CSV.decode(headers: [:id, :sku, :units_sold, :unit_price, :title, :average_discount])
    # |> Enum.each(fn {:ok, map} ->
    #   Product.changeset(
    #     %Product{},
    #     %{id: map[:id],
    #     sku: map[:sku],
    #     title: map[:title],
    #     units_sold: map[:units_sold],
    #     unit_price: map[:unit_price],
    #     average_discount: map[:average_discount]
    #   }) |> Repo.insert!()
    #   other -> IO.inspect(other, label: "Unexpected") end)


# end

# Repo.insert!(%Product{
#   title: "Fortnite 'Chug Jug' Coffee Mug (15 oz.)",
#   sku: "1032-9816-58976028-47456",
#   unit_price: "14.95",
#   average_discount: "0.0",
#   units_sold: "1"
# })
