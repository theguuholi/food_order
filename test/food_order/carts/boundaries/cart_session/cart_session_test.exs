defmodule FoodOrder.Carts.Boundaries.CartSessionTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory

  alias FoodOrder.Carts.Data.Cart

  test "should insert without cart" do
    result = GenServer.cast(:cart_session, {:insert, 11_111_333})
    assert :ok == result
  end

  test "should create a new session" do
    result = GenServer.cast(:cart_session, {:insert, 43_434_433})
    assert :ok == result

    result = GenServer.call(:cart_session, {:get, 43_434_433})
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

  test "should add item" do
    session_id = :rand.uniform(1000)
    result = GenServer.cast(:cart_session, {:insert, session_id})
    assert :ok == result

    product = insert(:product, %{})
    product_2 = insert(:product, %{})
    product_3 = insert(:product, %{})

    GenServer.cast(:cart_session, {:put, session_id, product})
    GenServer.cast(:cart_session, {:put, session_id, product_2})
    GenServer.cast(:cart_session, {:put, session_id, product_3})

    {:ok, result} = GenServer.call(:cart_session, {:get, session_id})
    assert 3 == result.total_qty

    assert 4 == GenServer.call(:cart_session, {:add, session_id, product_2.id}).total_qty
  end

  test "should remove item" do
    session_id = :rand.uniform(1000)
    result = GenServer.cast(:cart_session, {:insert, session_id})
    assert :ok == result

    product = insert(:product, %{})
    product_2 = insert(:product, %{})
    product_3 = insert(:product, %{})

    GenServer.cast(:cart_session, {:put, session_id, product})
    GenServer.cast(:cart_session, {:put, session_id, product_2})
    GenServer.cast(:cart_session, {:put, session_id, product_3})

    {:ok, result} = GenServer.call(:cart_session, {:get, session_id})
    assert 3 == result.total_qty

    assert 2 == GenServer.call(:cart_session, {:remove, session_id, product_2.id}).total_qty
  end
end
