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
end
