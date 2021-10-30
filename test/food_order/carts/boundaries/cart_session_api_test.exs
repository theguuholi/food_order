defmodule FoodOrder.Carts.Boundaries.CartSessionApiTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory

  alias FoodOrder.Carts.Boundaries.CartSessionApi

  test "should return error" do
    assert {:not_found, []} == CartSessionApi.get(2_232_323)
  end

  test "should create session" do
    assert :ok == CartSessionApi.insert(333)
  end

  test "should create a new product and get" do
    assert :ok == CartSessionApi.insert(333)
    product = insert(:product, %{})
    assert :ok == CartSessionApi.update(333, product)
    assert 1 == CartSessionApi.get(333).total_qty
  end

  test "should add product and get" do
    session_id = :rand.uniform(1000)

    assert :ok == CartSessionApi.insert(session_id)
    product = insert(:product, %{})
    assert :ok == CartSessionApi.update(session_id, product)
    assert :ok == CartSessionApi.add(session_id, product.id)
    assert 2 == CartSessionApi.get(session_id).total_qty
  end

  test "should remove product and get" do
    session_id = :rand.uniform(1000)

    assert :ok == CartSessionApi.insert(session_id)
    product = insert(:product, %{})
    assert :ok == CartSessionApi.update(session_id, product)
    assert :ok == CartSessionApi.remove(session_id, product.id)
    assert 0 == CartSessionApi.get(session_id).total_qty
  end
end
