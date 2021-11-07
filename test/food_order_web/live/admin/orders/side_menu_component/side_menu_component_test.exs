defmodule FoodOrderWeb.Admin.SideMenuComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "side menu", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/orders")
    assert has_element?(view, "#orders-status")
    assert has_element?(view, "#orders-status-title", "Orders")

    assert has_element?(view, "#orders-all-status", "All")
    assert has_element?(view, "#orders-all-status-quantity", "30")

    assert has_element?(view, "#orders-preparing", "Preparing")
    assert has_element?(view, "#orders-preparing-quantity", "3")

    assert has_element?(view, "#orders-delivering", "Delivering")
    assert has_element?(view, "#orders-delivering-quantity", "3")

    assert has_element?(view, "#orders-delivered", "Delivered")
    assert has_element?(view, "#orders-delivered-quantity", "1")
  end
end
