defmodule FoodOrderWeb.Admin.Orders.SideMenuComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Orders

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_orders_status()}
  end

  defp assign_orders_status(socket) do
    order_status = Orders.all_status_orders()
    assign(socket, order_status: order_status)
  end
end
