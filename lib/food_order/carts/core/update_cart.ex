defmodule FoodOrder.Carts.Core.UpdateCart do
  alias FoodOrder.Carts.Data.Cart

  def new, do: %Cart{}

  def execute(cart, product) do
    %Cart{
      cart
      | items: new_item(cart.items, product),
        total_qty: cart.total_qty + 1,
        total_price: Money.add(cart.total_price, product.price)
    }
  end

  defp new_item(items, product) do
    is_there_item_id? = Enum.find(items, & &1.item.id == product.id)

    if is_there_item_id? == nil do
      items ++ [%{item: product, qty: 1}]
    else
      items
      |> Map.new(fn item -> {item.item.id, item} end )
      |> Map.update!(product.id, &%{&1 | qty: &1.qty + 1})
      |> Map.values()
    end
  end
end
