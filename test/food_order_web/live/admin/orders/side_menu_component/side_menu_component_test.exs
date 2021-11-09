defmodule FoodOrderWeb.Admin.SideMenuComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "side menu", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/orders")
    assert has_element?(view, "[data-role=orders-status]")
    assert has_element?(view, "[data-id=title]", "Orders")

    assert has_element?(view, "[data-role=status-all]", "All")
    assert has_element?(view, "[data-role=status-all-qty]", "0")

    assert has_element?(view, "[data-role=status-not-started]", "Not Started")
    assert has_element?(view, "[data-role=status-not-started-qty]", "0")

    assert has_element?(view, "[data-role=status-received]", "Received")
    assert has_element?(view, "[data-role=status-received-qty]", "0")

    assert has_element?(view, "[data-role=status-preparing]", "Preparing")
    assert has_element?(view, "[data-role=status-preparing-qty]", "0")

    assert has_element?(view, "[data-role=status-delivering]", "Delivering")
    assert has_element?(view, "[data-role=status-delivering-qty]", "0")

    assert has_element?(view, "[data-role=status-delivered]", "Delivered")
    assert has_element?(view, "[data-role=status-delivered-qty]", "0")
  end
end
