defmodule FoodOrder.Orders.Core.UpdateOrderStatus do
  alias FoodOrder.Carts
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
  end

  def subscribe, do: PubSub.subscribe(FoodOrder.PubSub, @topic)

  def broadcast({:error, _} = err, _e, _), do: err

  def broadcast({:ok, order} = result, event, old_status) do
    Phoenix.PubSub.broadcast(FoodOrder.PubSub, @topic, {event, order, old_status})
    result
  end
end
