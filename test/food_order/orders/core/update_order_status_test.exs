defmodule FoodOrder.Orders.Core.UpdateOrderStatusTest do
  use FoodOrder.DataCase
  alias FoodOrder.Orders.Core.UpdateOrderStatus
  import FoodOrder.Factory

  describe "update order" do
    test "update with success" do
      order = insert(:order)
      {:ok, result} = UpdateOrderStatus.execute(order.id, order.status, :DELIVERED)
      refute order.status == result.status
    end
  end
end
