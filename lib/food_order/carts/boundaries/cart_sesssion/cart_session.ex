defmodule FoodOrder.Carts.Boundaries.CartSession do
  use GenServer
  alias FoodOrder.Carts.Core.NewCart
  alias FoodOrder.Carts.Core.UpdateCart

  def start_link(_), do: GenServer.start_link(__MODULE__, :cart_session, name: :cart_session)

  def init(name) do
    :ets.new(name, [:set, :public, :named_table])
    {:ok, name}
  end

  def handle_cast({:insert, user_id}, name) do
    case get_list(name, user_id) do
      {:not_found, []} -> :ets.insert(name, {user_id, NewCart.new()})
      {:ok, _value} -> :return_cache
    end

    {:noreply, name}
  end

  def handle_cast({:put, user_id, product}, name) do
    {:ok, cart} = get_list(name, user_id)
    cart = UpdateCart.execute(cart, product)
    :ets.insert(name, {user_id, cart})
    {:noreply, name}
  end

  def handle_call({:get, user_id}, _from, name) do
    {:reply, get_list(name, user_id), name}
  end

  defp get_list(name, user_id) do
    :ets.lookup(name, user_id)
    |> case do
      [] -> {:not_found, []}
      [{_user_id, value}] -> {:ok, value}
    end
  end
end
