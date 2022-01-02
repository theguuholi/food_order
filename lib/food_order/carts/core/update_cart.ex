defmodule FoodOrder.Carts.Core.UpdateCart do
  alias FoodOrder.Carts.Data.Cart

  def remove(cart, product_id) do
    {items, product_removed} =
      Enum.reduce(cart.items, {[], nil}, &remove_item(&1, &2, product_id))

    remove_value = Money.multiply(product_removed.item.price, product_removed.qty)

    %Cart{
      cart
      | items: items,
        total_qty: cart.total_qty - product_removed.qty,
        total_price: Money.subtract(cart.total_price, remove_value)
    }
  end

  defp remove_item(product, acc, product_id) do
    if product.item.id == product_id do
      {list, _product_acc} = acc
      {list, product}
    else
      {list, product_acc} = acc
      {[product] ++ list, product_acc}
    end
  end

  def add(cart, product_id) do
    {items_updated, product} =
      cart.items
      |> Enum.reduce({[], nil}, fn item, acc ->
        if item.item.id == product_id do
          {list, _} = acc
          updated_item = %{item | qty: item.qty + 1}
          item_updated = [updated_item]
          {list ++ item_updated, updated_item}
        else
          {list, item_updated} = acc
          {[item] ++ list, item_updated}
        end
      end)

    %Cart{
      cart
      | items: items_updated,
        total_qty: cart.total_qty + 1,
        total_price: Money.add(cart.total_price, product.item.price)
    }
  end

  def dec(cart, product_id) do
    {items_updated, product} =
      cart.items
      |> Enum.reduce({[], nil}, fn item, acc ->
        if item.item.id == product_id do
          {list, _} = acc
          updated_item = %{item | qty: item.qty - 1}

          if updated_item.qty == 0 do
            {list, updated_item}
          else
            item_updated = [updated_item]
            {list ++ item_updated, updated_item}
          end
        else
          {list, item_updated} = acc
          {[item] ++ list, item_updated}
        end
      end)

    %Cart{
      cart
      | items: items_updated,
        total_qty: cart.total_qty - 1,
        total_price: Money.subtract(cart.total_price, product.item.price)
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
