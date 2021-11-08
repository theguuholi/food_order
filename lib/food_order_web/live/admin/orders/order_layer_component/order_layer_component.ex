defmodule FoodOrderWeb.Admin.Orders.OrderLayerComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrderWeb.Orders.OrderLayer.CardComponent
  alias FoodOrder.Orders

  def update(%{id: id} = assigns, socket) do
    IO.inspect assigns
    orders = Orders.list_orders_by_status(id)
    {:ok, socket
    |> assign(assigns)
    |> assign(orders: orders)
  }
  end

  def card, do: CardComponent
end
