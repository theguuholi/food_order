defmodule FoodOrderWeb.Cart.Components.Order.OrderItem.OrderItemComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "validate order item", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/cart")
    assert has_element?(view, "#order-item-1")
    assert has_element?(view, "#order-item-details-1")

    assert is_there_id_with_text?(view, "#order-item-details-name-1", "Hamburguer")
    assert is_there_id_with_text?(view, "#order-item-details-size-1", "Big")
    assert is_there_id_with_text?(view, "#order-item-details-amount-1", "1 Pcs")
    assert is_there_id_with_text?(view, "#order-item-details-price-1", "$ 20")
  end
end
