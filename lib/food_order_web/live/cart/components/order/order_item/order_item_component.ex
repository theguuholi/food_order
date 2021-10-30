defmodule FoodOrderWeb.Cart.Components.Order.OrderItem.OrderItemComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Carts
  alias FoodOrderWeb.Cart.Components.OrderComponent

  # def handle_event("dec", _, socket) do
  #   {:noreply, socket}
  # end

  def handle_event("inc", %{"product_id" => product_id}, socket) do
    cart_id = socket.assigns.cart_id
    cart = Carts.add(product_id, cart_id)
    send_update(OrderComponent, id: "orders", order: cart)
    {:noreply, socket}
  end

  def handle_event("remove", %{"product_id" => product_id}, socket) do
    cart_id = socket.assigns.cart_id
    cart = Carts.remove(product_id, cart_id)
    send_update(OrderComponent, id: "orders", order: cart)
    {:noreply, socket}
  end
end
