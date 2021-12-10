defmodule FoodOrderWeb.Customer.OrderLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders
  alias FoodOrderWeb.Order.OrderRowComponent

  @impl true
  def mount(_assign, _session, socket) do
    current_user_id = socket.assigns.current_user.id
    if connected?(socket), do: Orders.subscribe_user_rows(current_user_id)
    orders = Orders.list_orders_by_user_id(current_user_id)
    {:ok, assign(socket, orders: orders)}
  end

  @impl true
  def handle_info({:order_row_updated, order}, socket) do
    send_update(OrderRowComponent, id: "order-row-#{order.id}", order: order)

    socket =
      socket
      |> put_flash(:info, "Order:#{order.id} was updated!")

    {:noreply, socket}
  end
end
