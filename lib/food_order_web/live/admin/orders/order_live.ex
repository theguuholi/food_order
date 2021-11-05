defmodule FoodOrderWeb.Admins.OrderLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  @impl true
  def mount(_assign, _session, socket) do
    {:ok,socket}
  end
end
