defmodule LiveWebStore.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveWebStore.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        average_discount: "120.5",
        sku: "some sku",
        title: "some title",
        unit_price: "120.5",
        units_sold: 42
      })
      |> LiveWebStore.Products.create_product()

    product
  end
end
