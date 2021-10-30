defmodule FoodOrderWeb.Cart.Components.OrderComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Carts
  alias FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponent
  alias FoodOrderWeb.Cart.Components.Order.OrderItem.OrderItemComponent


  @impl true
  def update(assigns, socket) do
    IO.inspect "here!!"
    IO.inspect assigns
    {:ok, socket |> assign(assigns)}
  end

  def order_item, do: OrderItemComponent
  def confirm_order, do: ConfirmOrderComponent
end
