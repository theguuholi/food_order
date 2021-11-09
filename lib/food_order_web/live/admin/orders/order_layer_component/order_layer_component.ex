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

  @impl true

  def handle_event("dropped", params, socket) do
    IO.inspect "dropped"
    IO.inspect params
    # implementation will go here
    {:noreply, socket}
  end

end
