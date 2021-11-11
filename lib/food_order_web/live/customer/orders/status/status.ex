defmodule FoodOrderWeb.Customer.OrderLive.Status do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  @impl true
  def mount(_assign, _session, socket) do
    current_user = socket.assigns.current_user
    {:ok, assign(socket, current_user: current_user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    if connected?(socket), do: Orders.subscribe_order(id)

    current_user_id = socket.assigns.current_user.id

    {:noreply,
     socket
     |> assign_order(id, current_user_id)
     |> assign_title()
     |> assign_status()
     |> assign_current_status()}
  end

  defp assign_order(socket, id, current_user_id) do
    order = Orders.get_order_by_id_and_customer_id(id, current_user_id)
    assign(socket, order: order)
  end

  defp assign_title(socket) do
    order_id = socket.assigns.order.id
    assign(socket, :page_title, "Order Status #{order_id}")
  end

  defp assign_status(socket) do
    status_list = Orders.get_order_status_values()
    assign(socket, :status_list, status_list)
  end

  defp assign_current_status(%{assigns: %{order: order}} = socket) do
    current_status = Orders.get_current_status(order.status)
    assign(socket, :current_status, current_status)
  end

  @impl true
  def handle_info({:order_updated, order}, socket) do
    current_status = Orders.get_current_status(order.status)

    socket =
      socket
      |> assign(:current_status, current_status)
      |> put_flash(:info, "Order:#{order.id} was updated!")

    {:noreply, socket}
  end
end
