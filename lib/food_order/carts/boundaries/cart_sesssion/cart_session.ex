defmodule FoodOrder.Carts.Boundaries.CartSession do
  use GenServer
  alias FoodOrder.Carts.Core.NewCart
  alias FoodOrder.Carts.Core.UpdateCart

  def start_link(_), do: GenServer.start_link(__MODULE__, :cart_session, name: :cart_session)

  def init(name) do
    :ets.new(name, [:set, :public, :named_table])
    {:ok, name}
  end

  def handle_cast({:delete_cart, cart_id}, name) do
    :ets.insert(name, {cart_id, NewCart.new()})
    {:noreply, name}
  end

  def handle_cast({:insert, cart_id}, name) do
    case get_list(name, cart_id) do
      {:not_found, []} -> :ets.insert(name, {cart_id, NewCart.new()})
      {:ok, _value} -> :return_cache
    end

    {:noreply, name}
  end

  def handle_cast({:put, cart_id, product}, name) do
    {:ok, cart} = get_list(name, cart_id)
    cart = UpdateCart.execute(cart, product)
    :ets.insert(name, {cart_id, cart})
    {:noreply, name}
  end

  def handle_call({:remove, cart_id, product_id}, _from, name) do
    {:ok, cart} = get_list(name, cart_id)
    cart = UpdateCart.remove(cart, product_id)
    :ets.insert(name, {cart_id, cart})
    {:reply, cart, name}
  end

  def handle_call({:add, cart_id, product_id}, _from, name) do
    {:ok, cart} = get_list(name, cart_id)
    cart = UpdateCart.add(cart, product_id)
    :ets.insert(name, {cart_id, cart})
    {:reply, cart, name}
  end

  def handle_call({:dec, cart_id, product_id}, _from, name) do
    {:ok, cart} = get_list(name, cart_id)
    cart = UpdateCart.dec(cart, product_id)
    :ets.insert(name, {cart_id, cart})
    {:reply, cart, name}
  end

  def handle_call({:get, cart_id}, _from, name) do
    {:reply, get_list(name, cart_id), name}
  end

  defp get_list(name, cart_id) do
    :ets.lookup(name, cart_id)
    |> case do
      [] -> {:not_found, []}
      [{_cart_id, value}] -> {:ok, value}
    end
  end
end
