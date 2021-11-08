defmodule FoodOrder.OrdersTest do
  use FoodOrder.DataCase
  import FoodOrder.AccountsFixtures
  import FoodOrder.ProductsFixtures

  alias FoodOrder.Carts
  alias FoodOrder.Orders
  alias FoodOrder.Orders.Core.AllStatusOrders

  describe "create order" do
    test "create_order_by_cart with success" do
      product = product_fixture()
      user = user_fixture()
      assert :ok == Carts.create_session(user.id)
      assert :ok == Carts.update_cart(product, user.id)
      assert 1 == Carts.get_cart(user.id).total_qty

      payload = %{
        "address" => nil,
        "current_user" => user.id,
        "phone_number" => nil
      }

      {:ok, result} = Orders.create_order_by_cart(payload)
      assert 1 == result.total_quantity
      assert 0 == Carts.get_cart(user.id).total_qty
    end

    test "list orders" do
      user = user_fixture()
      assert [] == Orders.list_orders_by_user_id(user.id)
    end

    test "list orders by status" do
      assert [] == Orders.list_orders_by_status(:NOT_STARTED)
    end

    test "count orders" do
      assert %AllStatusOrders{all: 0, delivered: 0, delivering: 0, not_started: 0, preparing: 0, received: 0} == Orders.all_status_orders()
    end
  end
end
