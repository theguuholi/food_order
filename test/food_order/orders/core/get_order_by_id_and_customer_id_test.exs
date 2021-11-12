defmodule FoodOrder.Orders.Core.GetOrderByIdAndCustomerIdTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory
  alias FoodOrder.Orders.Core.GetOrderByIdAndCustomerId

  describe "get order" do
    test "get_order_by_id_and_customer_id " do
      order = insert(:order)
      assert order.id == GetOrderByIdAndCustomerId.execute(order.id, order.user_id).id
    end
  end
end
