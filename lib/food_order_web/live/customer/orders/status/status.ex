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
    current_user_id = socket.assigns.current_user.id
    order = Orders.get_order_by_id_and_customer_id(id, current_user_id) |> IO.inspect()
    {:noreply,
     socket
     |> assign(:page_title, "Order Status #{order.id}")
     |> assign(:order, order)}
  end

end
