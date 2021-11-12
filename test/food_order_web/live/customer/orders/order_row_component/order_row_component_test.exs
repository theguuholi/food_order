defmodule FoodOrderWeb.Order.OrderRowComponentTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodOrder.Factory
  import Phoenix.HTML.Form, only: [humanize: 1]

  describe "load an entire row" do
    setup :register_and_log_in_user

    test "render row", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_path(conn, :index))

      assert has_element?(view, "[data-role=order-row][data-id=#{order.id}]")
      assert has_element?(view, "[data-role=order-show-status][data-id=#{order.id}]", order.id)
      assert has_element?(view, "[data-role=order-user][data-id=#{order.id}]", order.user_id)

      assert has_element?(
               view,
               "[data-role=order-status][data-id=#{order.id}]",
               humanize(order.status)
             )

      assert has_element?(
               view,
               "[data-role=order-date][data-id=#{order.id}]",
               NaiveDateTime.to_string(order.inserted_at)
             )
    end
  end
end
