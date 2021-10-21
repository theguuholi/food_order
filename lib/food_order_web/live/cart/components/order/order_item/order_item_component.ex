defmodule FoodOrderWeb.Cart.Components.Order.OrderItem.OrderItemComponent do
  use FoodOrderWeb, :live_component

  def handle_event("dec", _, socket) do
    IO.inspect("dev")
    {:noreply, socket}
  end

  def handle_event("inc", _, socket) do
    IO.inspect("inc")
    {:noreply, socket}
  end

  def handle_event("remove", _, socket) do
    IO.inspect("remove")
    {:noreply, socket}
  end
end
