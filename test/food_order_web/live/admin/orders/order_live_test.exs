defmodule FoodOrderWeb.Admin.OrdersTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest
  import FoodOrder.Factory
  alias FoodOrder.Carts
  alias FoodOrder.Orders

  describe "test products" do
    setup :register_and_log_in_user

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/orders")
      assert has_element?(view, "[data-role=orders-status]")
      assert has_element?(view, "#header-menu")
      assert has_element?(view, "[data-role=order-layer-title][data-id=NOT_STARTED]")
    end

    test "trigger event to create status", %{conn: conn, user: user} do
      {:ok, view, _html} = live(conn, "/admin/orders")
      assert has_element?(view, "[data-role=status-not-started-qty]", "0")
      product = insert(:product)
      Carts.create_session(user.id)
      Carts.update_cart(product, user.id)

      payload = %{
        "address" => Faker.Address.PtBr.street_address(),
        "current_user" => user.id,
        "phone_number" => Faker.Phone.PtBr.phone()
      }

      {:ok, order} = Orders.create_order_by_cart(payload)

      assert has_element?(view, "[data-role=status-not-started-qty]", "1")

      assert has_element?(
               view,
               "[data-role=order-number][data-id=NOT_STARTED-#{order.id}]",
               order.id
             )
    end

    test "trigger event to update status", %{conn: conn, user: user} do
      {:ok, view, _html} = live(conn, "/admin/orders")
      assert has_element?(view, "[data-role=status-not-started-qty]", "0")
      product = insert(:product)
      Carts.create_session(user.id)
      Carts.update_cart(product, user.id)

      payload = %{
        "address" => Faker.Address.PtBr.street_address(),
        "current_user" => user.id,
        "phone_number" => Faker.Phone.PtBr.phone()
      }

      {:ok, order} = Orders.create_order_by_cart(payload)

      assert has_element?(view, "[data-role=status-not-started-qty]", "1")

      assert has_element?(
               view,
               "[data-role=order-number][data-id=NOT_STARTED-#{order.id}]",
               order.id
             )

      {:ok, order} = Orders.update_order_status(order.id, :NOT_STARTED, :RECEIVED)

      refute has_element?(view, "[data-role=status-not-started-qty]", "1")
      assert has_element?(view, "[data-role=status-received-qty]", "1")

      assert has_element?(
               view,
               "[data-role=order-number][data-id=RECEIVED-#{order.id}]",
               order.id
             )
    end
  end
end
