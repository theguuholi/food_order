defmodule FoodOrder.Carts.Boundaries.CartSessionApi do
  def get(cart_id) do
    case GenServer.call(:cart_session, {:get, cart_id}) do
      {:ok, cart} -> cart
      err -> err
    end
  end

  def update(cart_id, product), do: GenServer.cast(:cart_session, {:put, cart_id, product})
  def insert(cart_id), do: GenServer.cast(:cart_session, {:insert, cart_id})
end
