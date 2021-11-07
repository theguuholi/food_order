defmodule FoodOrderWeb.Admin.CardComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "load card", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/orders")
    assert has_element?(view, "#card-pumpkin-1")
    assert has_element?(view, "#card-pumpkin-1-order", "Order #123")
    assert has_element?(view, "#card-pumpkin-1-order-items-title", "Order Items")
    assert has_element?(view, "#card-pumpkin-1-order-items")
    assert has_element?(view, "#card-pumpkin-1-order-item-1-name", "3 - Item 123")
    assert has_element?(view, "#card-pumpkin-1-order-item-1-price", "$ 10")
  end
end
