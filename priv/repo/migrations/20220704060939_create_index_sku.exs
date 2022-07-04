defmodule LiveWebStore.Repo.Migrations.CreateIndexSku do
  use Ecto.Migration

  def change do
    create index(:products, [:sku])
  end
end
