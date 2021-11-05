defmodule FoodOrder.OrdersTest do
  use FoodOrder.DataCase
  import FoodOrder.AccountsFixtures
  import FoodOrder.ProductsFixtures

  alias FoodOrder.Carts
  alias FoodOrder.Orders

  describe "create order" do
    test "create_order_by_cart with success" do
      product = product_fixture()
      user = user_fixture()
      assert :ok == Carts.create_session(user.id)
      assert :ok == Carts.update_cart(product, user.id)
      assert 1 == Carts.get_cart(user.id).total_qty

      {:ok, result} = Orders.create_order_by_cart(user.id)
      assert 1 == result.total_quantity
      assert 0 == Carts.get_cart(user.id).total_qty
    end

    test "list orders" do
      user = user_fixture()
      assert [] == Orders.list_orders_by_user_id(user.id)
    end
  end
end
