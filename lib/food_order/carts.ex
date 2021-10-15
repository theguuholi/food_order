defmodule FoodOrder.Carts do
  def update_cart(product) do
    cart = %{
      items: [
        %{
          product: product,
          qty: 0
        },
        total_qty: 0,
        total_price: 0
      ]
    }

    # for the first time create a cart and adding basic object structure
    #if !session.cart  create one
    # else
    #
    cart
  end
end
