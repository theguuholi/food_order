defmodule FoodOrder.Orders do
  alias FoodOrder.Orders.Core.AllStatusOrders
  alias FoodOrder.Orders.Core.CreateOrderByCart
  alias FoodOrder.Orders.Core.GetOrderByIdAndCustomerId
  alias FoodOrder.Orders.Core.ListOrdersByStatus
  alias FoodOrder.Orders.Core.ListOrdersByUserId
  alias FoodOrder.Orders.Core.UpdateOrderStatus
  alias FoodOrder.Orders.Data.Order

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

  def subscribe_user_rows(user_id) do
    UpdateOrderStatus.subscribe_user_rows(user_id)
  end

  def subscribe_order(order_id) do
    UpdateOrderStatus.subscribe_order(order_id)
  end

  def get_order_by_id_and_customer_id(id, customer_id) do
    GetOrderByIdAndCustomerId.execute(id, customer_id)
  end

  def get_order_status_values do
    Order
    |> Ecto.Enum.values(:status)
    |> Enum.with_index()
  end

  def get_current_status(current_status) do
    {_status, value} = Enum.find(get_order_status_values(), fn {status, _index} -> status == current_status end)
    value
  end
end
