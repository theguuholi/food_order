defmodule FoodOrderWeb.Admin.OrdersTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "render main elements", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/orders")
    assert has_element?(view, "#orders-status")
    assert has_element?(view, "#header-menu")
    assert has_element?(view, "[data-role=order-layer-title][data-id=NOT_STARTED]")
  end
end
