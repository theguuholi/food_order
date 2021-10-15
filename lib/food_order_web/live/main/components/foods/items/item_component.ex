defmodule FoodOrderWeb.Main.Components.Foods.ItemComponent do
  use FoodOrderWeb, :live_component

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  defp get_product(socket) do
    socket.assigns.product
  end

  def handle_event("add", _params, socket) do
    get_product(socket)
    {:noreply, socket}
  end
end
