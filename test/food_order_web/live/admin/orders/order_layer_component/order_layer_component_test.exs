defmodule FoodOrderWeb.Admin.OrderLayerComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "load board", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/orders")
    assert has_element?(view, "[data-role=order-board][data-id=NOT_STARTED]")
    assert has_element?(view, "[data-role=order-layer-title][data-id=NOT_STARTED]", "Not started")
  end
end
