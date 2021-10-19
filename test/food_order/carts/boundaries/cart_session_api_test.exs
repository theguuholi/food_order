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
end
