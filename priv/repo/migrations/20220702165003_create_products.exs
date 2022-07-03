defmodule LiveWebStore.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :sku, :string
      add :units_sold, :integer
      add :unit_price, :decimal
      add :title, :string
      add :average_discount, :decimal

      timestamps()
    end
  end

end
