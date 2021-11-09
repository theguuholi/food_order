defmodule FoodOrderWeb.Admin.CardComponentTest do
  use FoodOrderWeb.ConnCase

  import FoodOrder.Factory
  alias FoodOrder.Orders
  import Phoenix.LiveViewTest


  test "load card", %{conn: conn} do
    insert(:order)

    {:ok, view, _html} = live(conn, "/admin/orders")

    order = Orders.list_orders_by_status(:NOT_STARTED) |> hd

    assert has_element?(view, "[data-role=card-board][data-id=NOT_STARTED-#{order.id}]")
    assert has_element?(view, "[data-role=order-number][data-id=NOT_STARTED-#{order.id}]", order.id)
    assert has_element?(view, "[data-role=order-items][data-id=NOT_STARTED]", "Order Items")
    assert has_element?(view, "[data-role=items-list][data-id=NOT_STARTED]")
    assert has_element?(view, "[data-role=item][data-id=NOT_STARTED-#{order.id}-#{hd(order.items).id}]")
    assert has_element?(view, "[data-role=item-details][data-id=NOT_STARTED-#{order.id}-#{hd(order.items).id}]", "#{hd(order.items).quantity} - #{hd(order.items).product.name}")
    assert has_element?(view, "[data-role=item-price][data-id=NOT_STARTED-#{order.id}-#{hd(order.items).id}]", "#{Money.to_string(hd(order.items).product.price)}")
    assert has_element?(view, "[data-role=order-description-title]", "Order Description")
    assert has_element?(view, "[data-role=total-cost]", "Total Cost:")
    assert has_element?(view, "[data-role=total-cost-amount][data-id=NOT_STARTED-#{order.id}]", "#{Money.to_string(order.total_price)}")
    assert has_element?(view, "[data-role=total-items]", "Total Item:")
    assert has_element?(view, "[data-role=total-items-amount][data-id=NOT_STARTED-#{order.id}]", "#{order.total_quantity}")
    assert has_element?(view, "[data-role=customer][data-id=NOT_STARTED-#{order.id}]", "#{order.user.email}")
  end
end
