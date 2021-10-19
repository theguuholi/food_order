defmodule FoodOrder.Carts.Boundaries.CartSessionTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory

  alias FoodOrder.Carts.Data.Cart

  test "should insert without cart" do
    result = GenServer.cast(:cart_session, {:insert, 11_111_333})
    assert :ok == result
  end

  test "should create a new session" do
    result = GenServer.cast(:cart_session, {:insert, 123})
    assert :ok == result

    result = GenServer.call(:cart_session, {:get, 123})
    assert {:ok, %Cart{}} == result
  end

  test "should create a inser a new item" do
    result = GenServer.cast(:cart_session, {:insert, 123})
    assert :ok == result

    product = insert(:product, %{})

    GenServer.cast(:cart_session, {:put, 123, product})

    {:ok, result} = GenServer.call(:cart_session, {:get, 123})
    assert 1 == result.total_qty
  end
end
