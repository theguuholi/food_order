defmodule FoodOrder.Orders.Core.UpdateOrderStatus do
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Repo
  alias Phoenix.PubSub

  @topic "update-orders-admin"

  def execute(order_id, old_status, status) do
    Order
    |> Repo.get(order_id)
    |> Order.changeset(%{status: status})
    |> Repo.update()
    |> broadcast(:order_status_updated, old_status)
    |> broadcast_row(:order_row_updated)
    |> broadcast_order(:order_updated)
  end

  def subscribe, do: PubSub.subscribe(FoodOrder.PubSub, @topic)

  def subscribe_user_rows(user_id),
    do: PubSub.subscribe(FoodOrder.PubSub, "update-row:#{user_id}")

  def subscribe_order(order_id), do: PubSub.subscribe(FoodOrder.PubSub, "order:#{order_id}")

  def broadcast_row({:ok, order} = result, event) do
    Phoenix.PubSub.broadcast(FoodOrder.PubSub, "update-row:#{order.user_id}", {event, order})
    result
  end

  def broadcast_order({:ok, order} = result, event) do
    Phoenix.PubSub.broadcast(FoodOrder.PubSub, "order:#{order.id}", {event, order})
    result
  end

  def broadcast({:ok, order} = result, event, old_status) do
    Phoenix.PubSub.broadcast(FoodOrder.PubSub, @topic, {event, order, old_status})
    result
  end
end
