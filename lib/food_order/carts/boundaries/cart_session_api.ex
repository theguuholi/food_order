defmodule FoodOrder.Carts.Boundaries.CartSessionApi do
  def get(cart_id) do
    case GenServer.call(:cart_session, {:get, cart_id}) do
      {:ok, cart} -> cart
      err -> err
    end
  end

  def delete_cart(cart_id), do: GenServer.cast(:cart_session, {:delete_cart, cart_id})

  def add(cart_id, product_id), do: GenServer.call(:cart_session, {:add, cart_id, product_id})
  def dec(cart_id, product_id), do: GenServer.call(:cart_session, {:dec, cart_id, product_id})

  def remove(cart_id, product_id),
    do: GenServer.call(:cart_session, {:remove, cart_id, product_id})

  def update(cart_id, product), do: GenServer.cast(:cart_session, {:put, cart_id, product})
  def insert(cart_id), do: GenServer.cast(:cart_session, {:insert, cart_id})
end
