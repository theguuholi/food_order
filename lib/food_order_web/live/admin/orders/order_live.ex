defmodule FoodOrderWeb.Admin.OrderLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Admin.Orders.{HeaderMenuComponent, OrderLayerComponent, SideMenuComponent}
  alias FoodOrder.Orders

  @impl true
  def mount(_assign, _session, socket) do
    if connected?(socket), do: Orders.subscribe_update_order_status
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
end
