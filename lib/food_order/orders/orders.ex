defmodule FoodOrder.Orders do
  alias FoodOrder.Orders.Core.CreateOrderByCart

  def create_order_by_cart(params) do
    CreateOrderByCart.execute(params)
  end
end
