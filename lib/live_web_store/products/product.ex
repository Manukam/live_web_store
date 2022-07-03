defmodule LiveWebStore.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :average_discount, :decimal
    field :sku, :string
    field :title, :string
    field :unit_price, :decimal
    field :units_sold, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:id, :sku, :units_sold, :unit_price, :title, :average_discount])
    |> validate_required([:id, :sku, :units_sold, :unit_price, :title, :average_discount])
    |> unique_constraint(:sku)
  end
end
