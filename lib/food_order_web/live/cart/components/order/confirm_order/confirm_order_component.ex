defmodule FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Carts

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def handle_event("create_order", params, socket) do
    # IO.inspect params
    cart = Carts.get_cart(params["current_user"])
    IO.inspect cart
    # Order
    # - belongs user
    # - has many items
    #   - item:
    #     product_id
    #     quantity
    # - total_price
    # - total_quantity:
    # payment_type

    {:noreply, socket}
  end
end
