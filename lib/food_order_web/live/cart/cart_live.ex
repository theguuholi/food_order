defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Carts
  alias FoodOrderWeb.Cart.Components.EmptyCartComponent
  alias FoodOrderWeb.Cart.Components.OrderComponent

  def mount(_assigns, _session, socket) do
    cart_id = socket.assigns.cart_id
    order = Carts.get_cart(cart_id)
    {:ok, socket |> assign(order: order) |> assign(cart_id: cart_id)}
  end

  def empty_cart, do: EmptyCartComponent
  @spec order :: FoodOrderWeb.Cart.Components.OrderComponent
  def order, do: OrderComponent
end
