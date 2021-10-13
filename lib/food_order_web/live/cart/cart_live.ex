defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Cart.Components.EmptyCartComponent
  alias FoodOrderWeb.Cart.Components.OrderComponent

  def mount(_assign, _session, socket) do
    {:ok, socket |> assign(empty_cart: false)}
  end

  def empty_cart, do: EmptyCartComponent
  def order, do: OrderComponent
end
