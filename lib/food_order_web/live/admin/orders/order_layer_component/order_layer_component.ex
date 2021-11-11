defmodule FoodOrderWeb.Admin.Orders.OrderLayerComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Orders
  alias FoodOrderWeb.Orders.OrderLayer.CardComponent

  @impl true
  def update(%{id: id} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_orders(id)}
  end

  def card, do: CardComponent

  defp assign_orders(socket, id) do
    orders = Orders.list_orders_by_status(id)
    assign(socket, orders: orders)
  end

  @impl true
  def handle_event(
        "dropped",
        %{"orderId" => order_id, "orderStatus" => next_status, "orderOldStatus" => old_status},
        socket
      ) do
    Orders.update_order_status(order_id, old_status, next_status)
    {:noreply, socket}
  end
end
