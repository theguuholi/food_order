defmodule FoodOrderWeb.CartChannel do
  use FoodOrderWeb, :channel
  alias FoodOrder.Carts


  def join("cart:" <> cart_id, _payload, socket) do
    total_qty = Carts.get_cart(cart_id).total_qty
    {:ok, %{total_qty: total_qty}, assign(socket, :cart_id, cart_id)}
  end
end
