defmodule FoodOrderWeb.Main.Components.FoodsComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "should load the load food information", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert has_element?(view, "#food-detail")
    assert is_there_id_with_text?(view, "#food-detail-text", "All Foods")
    assert has_element?(view, "#food-detail-products")
  end

end
