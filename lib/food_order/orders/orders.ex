defmodule FoodOrder.Orders do
  alias FoodOrder.Orders.Core.CreateOrderByCart
  alias FoodOrder.Orders.Core.ListOrdersByUserId

  def create_order_by_cart(params) do
    CreateOrderByCart.execute(params)
  end

  def list_orders_by_user_id(user_id) do
    ListOrdersByUserId.execute(user_id)
  end
end
