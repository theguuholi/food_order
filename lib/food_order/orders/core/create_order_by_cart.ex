defmodule FoodOrder.Orders.Core.CreateOrderByCart do
  alias FoodOrder.Carts
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Repo

  def execute(%{
        "address" => _address,
        "current_user" => current_user,
        "phone_number" => _phone_number
      }) do
    current_user
    |> Carts.get_cart()
    |> convert_item_session_to_payload_item()
    |> create_order_payload(current_user)
    |> Repo.insert()
    |> remove_cache()
  end

  def remove_cache({:ok, order}) do
    Carts.delete_cart(order.user_id)
    {:ok, order}
  end

  def remove_cache({:error, _} = err), do: err

  defp convert_item_session_to_payload_item(%{items: items} = cart) do
    payload_items =
      Enum.map(items, fn item ->
        %{quantity: item.qty, product_id: item.item.id}
      end)

    {cart, payload_items}
  end

  defp create_order_payload({cart, payload_items}, user_id) do
    total_price = cart.total_price
    total_quantity = cart.total_qty

    changeset = %{
      user_id: user_id,
      items: payload_items,
      total_quantity: total_quantity,
      total_price: total_price
    }

    Order.changeset(%Order{}, changeset)
  end
end
