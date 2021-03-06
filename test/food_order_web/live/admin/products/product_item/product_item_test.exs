defmodule FoodOrderWeb.Products.ProductItemComponentTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "test products" do
    setup :register_and_log_in_user

    test "should load the load product information", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, "/admin/products")
      assert has_element?(view, "#product-item-#{product.id}")
      assert has_element?(view, "#product-item-#{product.id}", product.name)
      assert has_element?(view, "#product-item-#{product.id}", Money.to_string(product.price))
      assert has_element?(view, "#product-item-#{product.id}", product.size)
    end
  end
end
