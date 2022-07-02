defmodule LiveWebStore.ProductsTest do
  use LiveWebStore.DataCase

  alias LiveWebStore.Products

  describe "products" do
    alias LiveWebStore.Products.Product

    import LiveWebStore.ProductsFixtures

    @invalid_attrs %{average_discount: nil, sku: nil, title: nil, unit_price: nil, units_sold: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{average_discount: "120.5", sku: "some sku", title: "some title", unit_price: "120.5", units_sold: 42}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.average_discount == Decimal.new("120.5")
      assert product.sku == "some sku"
      assert product.title == "some title"
      assert product.unit_price == Decimal.new("120.5")
      assert product.units_sold == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{average_discount: "456.7", sku: "some updated sku", title: "some updated title", unit_price: "456.7", units_sold: 43}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.average_discount == Decimal.new("456.7")
      assert product.sku == "some updated sku"
      assert product.title == "some updated title"
      assert product.unit_price == Decimal.new("456.7")
      assert product.units_sold == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
