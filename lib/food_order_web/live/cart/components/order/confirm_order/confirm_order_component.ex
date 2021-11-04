defmodule FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Orders

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def handle_event("create_order", params, socket) do
    Orders.create_order_by_cart(params)
    {:noreply, socket}
  end
end
