defmodule FoodOrderWeb.Main.Components.Foods.ItemComponentTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  test "should load the load item information", %{conn: conn} do
    product = insert(:product)
    product_2 = insert(:product)
    {:ok, view, _html} = live(conn, "/")
    assert has_element?(view, "#food-item-#{product.id}")
    assert has_element?(view, "#food-item-#{product_2.id}")
  end

  test "should load validade item details", %{conn: conn} do
    product = insert(:product)
    {:ok, view, _html} = live(conn, "/")
    assert is_there_id_with_text?(view, "#food-item-name-#{product.id}", product.name)
    assert is_there_id_with_text?(view, "#food-item-size-#{product.id}", product.size)
    assert is_there_id_with_text?(view, "#food-item-size-#{product.id}", product.size)
    assert is_there_id_with_text?(view, "#food-item-price-#{product.id}", Money.to_string(product.price))
    assert is_there_id_with_text?(view, "#food-item-add-#{product.id}", "add")
  end

end
