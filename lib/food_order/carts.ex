defmodule FoodOrder.Carts do
  def update_cart(product, cart_token) do
    cart = %{
      items: [
        %{
          product: product,
          qty: 1
        },
        total_qty: 0,
        total_price: 0
      ]
    }
  end
end
