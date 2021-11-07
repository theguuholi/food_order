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
    assert has_element?(view, "#card-pumpkin-1-order-description", "Order Description")
    assert has_element?(view, "#card-pumpkin-1-order-total-cost", "Total Cost:")
    assert has_element?(view, "#card-pumpkin-1-order-total-amount", "$ 50")
    assert has_element?(view, "#card-pumpkin-1-order-total-item", "Total Item:")
    assert has_element?(view, "#card-pumpkin-1-order-total-item-amount", "4")
    assert has_element?(view, "#card-pumpkin-1-order-customer-name", "Gustavo")
  end
end
