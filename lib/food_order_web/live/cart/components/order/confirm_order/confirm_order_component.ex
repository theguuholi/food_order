defmodule FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Orders

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def handle_event("create_order", params, socket) do
    # TODO INCLUDE
    # payment_type required
    # status required
    # phone required
    # address required
    # throw All fields are quired
    case Orders.create_order_by_cart(params) do
      {:ok, _order} ->
        socket =
          socket
          |> put_flash(:info, "Order Created with Success!")
          |> push_redirect(to: Routes.order_path(socket, :index))

        {:noreply, socket}

      {:error, _changeset} ->
        socket =
          socket
          |> put_flash(:error, "Something went wrong please verify your order")
          |> push_patch(to: Routes.cart_path(socket, :index))

        {:noreply, socket}
    end
  end
end
