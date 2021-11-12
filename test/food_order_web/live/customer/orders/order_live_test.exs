defmodule FoodOrderWeb.Customer.OrderLiveTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.HTML.Form, only: [humanize: 1]
  import Phoenix.LiveViewTest
  import FoodOrder.Factory
  alias FoodOrder.Orders

  describe "test order list" do
    setup :register_and_log_in_user

    test "render order", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.customer_order_path(conn, :index))
      render(view) =~ "No order found!"
    end

    test "update order with handle_info", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_path(conn, :index))

      assert has_element?(view, "[data-role=order-status][data-id=#{order.id}]", "Not started")

      {:ok, order} = Orders.update_order_status(order.id, :NOT_STARTED, :RECEIVED)

      refute has_element?(view, "[data-role=order-status][data-id=#{order.id}]", "Not started")

      assert has_element?(
               view,
               "[data-role=order-status][data-id=#{order.id}]",
               humanize(order.status)
             )

      assert view |> element(".alert-info", "Order:#{order.id} was updated!")
    end
  end
end
