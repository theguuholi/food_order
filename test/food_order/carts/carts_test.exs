defmodule FoodOrder.CartsTest do
  use FoodOrder.DataCase
  import FoodOrder.Factory

  alias FoodOrder.Carts

  test "should create session" do
    assert :ok == Carts.create_session(4444)
  end

  test "should create a new product and get" do
    assert :ok == Carts.create_session(4444)
    product = insert(:product, %{})
    assert :ok == Carts.update_cart(product, 4444)
    assert 1 == Carts.get_cart(4444).total_qty
  end

  test "should delete cart" do
    session_id = :rand.uniform(1000)

    assert :ok == Carts.create_session(session_id)
    product = insert(:product, %{})
    assert :ok == Carts.update_cart(product, session_id)
    assert :ok == Carts.delete_cart(session_id)
  end

  test "should add product and get" do
    session_id = :rand.uniform(1000)

    assert :ok == Carts.create_session(session_id)
    product = insert(:product, %{})
    assert :ok == Carts.update_cart(product, session_id)
    assert 2 == Carts.add(product.id, session_id).total_qty
  end

  test "should dec product and get" do
    session_id = :rand.uniform(1000)

    assert :ok == Carts.create_session(session_id)
    product = insert(:product, %{})
    assert :ok == Carts.update_cart(product, session_id)
    assert 0 == Carts.dec(product.id, session_id).total_qty
  end
end
