defmodule FoodOrderWeb.Customer.OrderLive.StatusTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.HTML.Form, only: [humanize: 1]
  import Phoenix.LiveViewTest
  import FoodOrder.Factory
  alias FoodOrder.Orders

  describe "test status" do
    setup :register_and_log_in_user

    test "render status", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_status_path(conn, :status, order.id))
      render(view) =~ "Track delivery status"
    end

    test "back to order list", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_status_path(conn, :status, order.id))

      assert has_element?(
               view,
               "[data-id=order-list]",
               "< Back"
             )

      {:ok, _view, html} =
        view
        |> element("[data-id=order-list]", "< Back")
        |> render_click()
        |> follow_redirect(conn, Routes.customer_order_path(conn, :index))

      assert html =~ "All Orders"
    end

    test "load elements on the screen", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_status_path(conn, :status, order.id))

      assert has_element?(
               view,
               "[data-id=title-screen]",
               "Track delivery status"
             )

      assert has_element?(
               view,
               "[data-id=order-id]",
               order.id
             )

      assert view
             |> element("[data-role=status-item][data-id=NOT_STARTED]")
             |> render =~ "current"

      for {status, _index} <- Orders.get_order_status_values() do
        assert has_element?(
                 view,
                 "[data-role=order-status][data-id=#{status}]",
                 humanize(status)
               )
      end
    end

    test "load elements completed", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      Orders.update_order_status(order.id, :NOT_STARTED, :DELIVERED)
      {:ok, view, _html} = live(conn, Routes.customer_order_status_path(conn, :status, order.id))

      assert view
             |> element("[data-role=status-item][data-id=NOT_STARTED]")
             |> render =~ "step-completed"
    end

    test "update element status", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_status_path(conn, :status, order.id))

      assert view
             |> element("[data-role=status-item][data-id=NOT_STARTED]")
             |> render =~ "current"

      {:ok, order} = Orders.update_order_status(order.id, :NOT_STARTED, :RECEIVED)

      assert view
             |> element("[data-role=status-item][data-id=NOT_STARTED]")
             |> render =~ "step-completed"

      assert view
             |> element("[data-role=status-item][data-id=RECEIVED]")
             |> render =~ "current"

      assert view |> element(".alert-info", "Order:#{order.id} was updated!")

      send(view.pid, {:order_updated, %{id: 123, status: :PREPARING}})

      assert view
             |> element("[data-role=status-item][data-id=RECEIVED]")
             |> render =~ "step-completed"

      assert view
             |> element("[data-role=status-item][data-id=PREPARING]")
             |> render =~ "current"

      assert view |> element(".alert-info", "Order:123 was updated!")
    end
  end
end
