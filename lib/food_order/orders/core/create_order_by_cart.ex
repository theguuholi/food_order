defmodule FoodOrder.Orders.Core.CreateOrderByCart do
  alias FoodOrder.Carts
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Repo
  alias Phoenix.PubSub

  def execute(%{
        "address" => address,
        "current_user" => current_user,
        "phone_number" => phone_number
      }) do
    current_user
    |> Carts.get_cart()
    |> convert_item_session_to_payload_item()
    |> create_order_payload(current_user, address, phone_number)
    |> Repo.insert()
    |> broadcast(:create_order)
    |> remove_cache()
  end

  def subscribe, do: PubSub.subscribe(FoodOrder.PubSub, "new_orders")

  def broadcast({:error, _} = err, _), do: err

  def broadcast({:ok, order} = result, event) do
    Phoenix.PubSub.broadcast(FoodOrder.PubSub, "new_orders", {event, order})
    result
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

  defp create_order_payload({cart, payload_items}, user_id, address, phone_number) do
    total_price = cart.total_price
    total_quantity = cart.total_qty

    changeset = %{
      user_id: user_id,
      address: address,
      phone_number: phone_number,
      items: payload_items,
      total_quantity: total_quantity,
      total_price: total_price
    }

    Order.changeset(%Order{}, changeset)
  end
end
