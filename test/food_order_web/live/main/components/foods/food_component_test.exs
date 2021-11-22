defmodule FoodOrderWeb.Main.Components.FoodsComponentTest do
  use FoodOrderWeb.ConnCase

  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  test "should load the load food information", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert has_element?(view, "#food-detail")
    assert is_there_id_with_text?(view, "#food-detail-text", "All Foods")
    assert has_element?(view, "#food-detail-products")
  end

  test "should load more elements", %{conn: conn} do
    products = for _ <- 0..20, do: insert(:product, %{})

    {:ok, view, _html} = live(conn, "/")

    [products_list_1, products_list_2 | _rest] = Enum.chunk_every(products, 8)

    Enum.each(products_list_1, fn product ->
      assert has_element?(view, "#food-item-#{product.id}")
    end)

    Enum.each(products_list_2, fn product ->
      refute has_element?(view, "#food-item-#{product.id}")
    end)

    view
    |> element("#products-loading")
    |> render_hook("load_products", %{})

    Enum.each(products_list_2, fn product ->
      assert has_element?(view, "#food-item-#{product.id}")
    end)
  end
end
