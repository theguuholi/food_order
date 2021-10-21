defmodule FoodOrder.Carts.Data.Cart do
  defstruct items: [], total_qty: 0, total_price: Money.new(0)
end
