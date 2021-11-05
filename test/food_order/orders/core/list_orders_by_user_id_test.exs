defmodule FoodOrder.Orders.Core.ListOrdersByUserIdTest do
  use FoodOrder.DataCase
  import FoodOrder.AccountsFixtures
  alias FoodOrder.Orders.Core.ListOrdersByUserId

  describe "list order" do
    test "list_orders_by_user_id with success" do
      user = user_fixture()
      assert [] == ListOrdersByUserId.execute(user.id)
    end
  end
end
