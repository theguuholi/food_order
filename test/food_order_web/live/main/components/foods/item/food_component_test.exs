defmodule FoodOrderWeb.Main.Components.Foods.ItemComponentTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  test "should load the load item information", %{conn: conn} do
    insert(:product)
    {:ok, view, _html} = live(conn, "/")
    assert has_element?(view, "#food-item")
    # assert is_there_id_with_text?(view, "#food-detail-text", "All Foods")
    # assert has_element?(view, "#food-detail-products")
  end

end
