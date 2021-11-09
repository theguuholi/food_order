defmodule FoodOrder.Orders do
  alias FoodOrder.Orders.Core.AllStatusOrders
  alias FoodOrder.Orders.Core.CreateOrderByCart
  alias FoodOrder.Orders.Core.ListOrdersByStatus
  alias FoodOrder.Orders.Core.ListOrdersByUserId
  alias FoodOrder.Orders.Core.UpdateOrderStatus

  def create_order_by_cart(params) do
    CreateOrderByCart.execute(params)
  end

  def list_orders_by_user_id(user_id) do
    ListOrdersByUserId.execute(user_id)
  end

  def list_orders_by_status(status) do
    ListOrdersByStatus.execute(status)
  end

  def all_status_orders do
    AllStatusOrders.execute()
  end

  def update_order_status(order_id, old_status, status) do
    UpdateOrderStatus.execute(order_id, old_status, status)
  end

  def subscribe_update_order_status() do
    UpdateOrderStatus.subscribe
  end
end
