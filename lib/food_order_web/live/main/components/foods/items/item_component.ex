defmodule FoodOrderWeb.Main.Components.Foods.ItemComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Carts

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  defp get_product(socket) do
    socket.assigns.product
  end

  defp update_cart(socket, current_user_id) do
    socket
    |> get_product()
    |> Carts.update_cart(current_user_id)
  end

  def handle_event("add", _params, socket) do
    update_cart(socket, socket.assigns.current_user.id)

    socket =
      socket
      |> put_flash(:info, "Item added to cart")
      |> push_redirect(to: "/")

    {:noreply, socket}
  end
end
