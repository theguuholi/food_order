defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Carts
  alias FoodOrderWeb.Cart.Components.EmptyCartComponent
  alias FoodOrderWeb.Cart.Components.OrderComponent

  def mount(_assign, _session, socket) do
    order = Carts.get_cart(socket.assigns.user)
    {:ok, socket |> assign(order: order)}
  end

  def empty_cart, do: EmptyCartComponent
  def order, do: OrderComponent
end
