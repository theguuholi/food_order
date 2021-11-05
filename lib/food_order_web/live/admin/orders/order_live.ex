defmodule FoodOrderWeb.Admin.OrderLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Admin.Orders.{HeaderMenuComponent, SideMenuComponent}

  @impl true
  def mount(_assign, _session, socket) do
    {:ok,socket}
  end

  defp side_menu, do: SideMenuComponent
  defp header_menu, do: HeaderMenuComponent
end
