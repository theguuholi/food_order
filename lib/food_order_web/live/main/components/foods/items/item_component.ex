defmodule FoodOrderWeb.Main.Components.Foods.ItemComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Carts

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  defp get_product(socket) do
    socket.assigns.product
  end

  defp update_cart(socket, user) do
    socket
    |> get_product()
    |> Carts.update_cart(user)
  end

  def handle_event("add", _params, socket) do
    update_cart(socket, socket.assigns.user)
    socket = put_flash(socket, :info, "Item added to cart")
    {:noreply, socket}
  end
end
