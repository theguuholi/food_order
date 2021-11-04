defmodule FoodOrderWeb.OrderLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  @impl true
  def mount(_assign, _session, socket) do
    current_user_id = socket.assigns.current_user.id
    orders = Orders.list_orders_by_user_id(current_user_id)
    {:ok, assign(socket, orders: orders)}
  end
end
