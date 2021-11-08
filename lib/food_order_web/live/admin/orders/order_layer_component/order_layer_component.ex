defmodule FoodOrderWeb.Admin.Orders.OrderLayerComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Orders
  alias FoodOrderWeb.Orders.OrderLayer.CardComponent

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
end
