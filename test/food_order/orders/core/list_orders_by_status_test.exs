defmodule FoodOrder.Orders.Core.ListOrdersByStatusTest do
  use FoodOrder.DataCase
  alias FoodOrder.Orders.Core.ListOrdersByStatus

  describe "list orders" do
    test "by status" do
      assert [] == ListOrdersByStatus.execute(:NOT_STARTED)
    end
  end
end
