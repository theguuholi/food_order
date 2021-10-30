defmodule FoodOrder.Carts.Core.UpdateCart do
  alias FoodOrder.Carts.Data.Cart

  def remove(cart, product_id) do
    {items, product_removed} =
      cart.items
      |> Enum.reduce_while({[], nil}, fn product, acc ->
        if product.item.id == product_id do
          {list, _product_acc} = acc
          {:halt, {list, product}}
        else
          {list, product_acc} = acc
          {:cont, {[product] ++ list, product_acc}}
        end
      end)

    remove_value = Money.multiply(product_removed.item.price, product_removed.qty)

    %Cart{
      cart
      | items: items,
        total_qty: cart.total_qty - product_removed.qty,
        total_price: Money.subtract(cart.total_price, remove_value)
    }
  end

  def add(cart, product_id) do
    {items_updated, product} =
      cart.items
      |> Enum.reduce_while({[], nil}, fn item, acc ->
        if item.item.id == product_id do
          {list, _} = acc
          item_updated = [%{item | qty: item.qty + 1}]
          {:halt, {list ++ item_updated, item}}
        else
          {list, item_updated} = acc
          {:cont, {[item] ++ list, item_updated}}
        end
      end)

    %Cart{
      cart
      | items: items_updated,
        total_qty: cart.total_qty + 1,
        total_price: Money.add(cart.total_price, product.item.price)
    }
  end

  def execute(cart, product) do
    %Cart{
      cart
      | items: new_item(cart.items, product),
        total_qty: cart.total_qty + 1,
        total_price: Money.add(cart.total_price, product.price)
    }
  end

  defp new_item(items, product) do
    is_there_item_id? = Enum.find(items, &(&1.item.id == product.id))

    if is_there_item_id? == nil do
      items ++ [%{item: product, qty: 1}]
    else
      items
      |> Map.new(fn item -> {item.item.id, item} end)
      |> Map.update!(product.id, &%{&1 | qty: &1.qty + 1})
      |> Map.values()
    end
  end
end
