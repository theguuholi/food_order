defmodule FoodOrderWeb.Admin.OrderLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders
  alias FoodOrderWeb.Admin.Orders.{HeaderMenuComponent, OrderLayerComponent, SideMenuComponent}

  @impl true
  def mount(_assign, _session, socket) do
    if connected?(socket) do
      Orders.subscribe_update_order_status()
      Orders.subscribe_create_order()
    end

    {:ok, socket}
  end

  defp side_menu, do: SideMenuComponent
  defp header_menu, do: HeaderMenuComponent
  defp order_layer, do: OrderLayerComponent

  @impl true
  def handle_info({:order_status_updated, %{status: new_status}, old_status}, socket) do
    send_update(SideMenuComponent, id: "side-menu-orders")
    send_update(OrderLayerComponent, id: old_status)
    send_update(OrderLayerComponent, id: Atom.to_string(new_status))
    {:noreply, socket}
  end

  @impl true
  def handle_info({:create_order, %{status: status}}, socket) do
    send_update(OrderLayerComponent, id: Atom.to_string(status))
    send_update(SideMenuComponent, id: "side-menu-orders")
    {:noreply, socket}
  end
end
