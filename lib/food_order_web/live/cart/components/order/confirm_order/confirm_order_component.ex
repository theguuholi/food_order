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
    # - belongs user, required
    # - has many items, required
    #   - item:
    #     product_id
    #     quantity
    # - total_price required
    # - total_quantity: required
    # TODO INCLUDE
    # payment_type required
    # status required
    # phone required
    # address required
    # field are not filled?
      # throw All fields are quired
    # throw success or error message
    # throw to customer/orders and user can see their orders

    {:noreply, socket}
  end
end
