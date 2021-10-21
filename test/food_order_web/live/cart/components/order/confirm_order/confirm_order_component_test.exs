defmodule FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponentTest do
  use FoodOrderWeb.ConnCase

  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  alias FoodOrder.Carts

  test "validate items in confirm order", %{conn: conn} do
    Carts.create_session("user123")
    product = insert(:product)
    Carts.update_cart(product, "user123")

    {:ok, view, _html} = live(conn, "/cart")
    assert has_element?(view, "#confirm-order")
    assert has_element?(view, "#confirm-order-summary")
    assert has_element?(view, "#confirm-order-form")

    assert is_there_id_with_text?(
             view,
             "#confirm-order-summary-total-amount",
             Money.to_string(Carts.get_cart("user123").total_price)
           )
  end
end
