defmodule FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "validate items in confirm order", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/cart")
    assert has_element?(view, "#confirm-order")
    assert has_element?(view, "#confirm-order-summary")
    assert has_element?(view, "#confirm-order-form")

    assert is_there_id_with_text?(view, "#confirm-order-summary-total-amount", "$ 80")
  end
end
