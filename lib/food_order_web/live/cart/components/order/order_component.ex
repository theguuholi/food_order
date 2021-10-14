defmodule FoodOrderWeb.Cart.Components.OrderComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrderWeb.Cart.Components.Order.OrderItem.OrderItemComponent
  alias FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponent

  def order_item, do: OrderItemComponent
  def confirm_order, do: ConfirmOrderComponent
end
