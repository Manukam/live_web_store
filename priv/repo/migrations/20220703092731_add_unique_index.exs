defmodule LiveWebStore.Repo.Migrations.AddUniqueIndex do
  use Ecto.Migration

  def change do
    create unique_index(:products, [:sku], name: :sku_unique)
  end
end
