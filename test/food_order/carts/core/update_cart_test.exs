defmodule FoodOrder.Carts.Core.UpdateCartTest do
  use FoodOrder.DataCase
  alias FoodOrder.Carts.Core.UpdateCart
  alias FoodOrder.Carts.Data.Cart
  import FoodOrder.Factory

  describe "update cart" do
    test "should create a new element on the cart" do
      cart = %Cart{}
      product = insert(:product, %{})
      result = UpdateCart.execute(cart, product)
      assert 1 == result.total_qty
      assert product.price == result.total_price
    end

    test "should create two items on the same cart" do
      cart = %Cart{}
      product = insert(:product, %{})

      result =
        cart
        |> UpdateCart.execute(product)
        |> UpdateCart.execute(product)

      assert 2 == result.total_qty
      assert Money.add(product.price, product.price) == result.total_price
    end

    test "should remove element " do
      cart = %Cart{}
      product = insert(:product, %{})
      product_1 = insert(:product, %{})

      result =
        cart
        |> UpdateCart.execute(product)
        |> UpdateCart.execute(product)
        |> UpdateCart.execute(product_1)
        |> UpdateCart.remove(product.id)

      assert 1 == result.total_qty

      assert product_1.price == result.total_price
    end

    test "should create add the same element into_the cart" do
      cart = %Cart{}
      product = insert(:product, %{})

      result =
        cart
        |> UpdateCart.execute(product)
        |> UpdateCart.execute(product)
        |> UpdateCart.add(product.id)

      assert 3 == result.total_qty

      assert product.price
             |> Money.add(product.price)
             |> Money.add(product.price) == result.total_price
    end

    test "should create dec the same element into_the cart" do
      cart = %Cart{}
      product = insert(:product, %{})

      result =
        cart
        |> UpdateCart.execute(product)
        |> UpdateCart.execute(product)
        |> UpdateCart.dec(product.id)

      assert 1 == result.total_qty

      assert product.price
             |> Money.add(product.price)
             |> Money.subtract(product.price) == result.total_price
    end

    test "should create dec until remove the element" do
      cart = %Cart{}
      product = insert(:product, %{})

      result =
        cart
        |> UpdateCart.execute(product)
        |> UpdateCart.execute(product)
        |> UpdateCart.dec(product.id)
        |> UpdateCart.dec(product.id)

      assert 0 == result.total_qty
      assert Money.new(0) == result.total_price
    end

    test "should create two different items on the same cart" do
      cart = %Cart{}
      product = insert(:product, %{})
      product_2 = insert(:product, %{})

      result =
        cart
        |> UpdateCart.execute(product)
        |> UpdateCart.execute(product_2)

      assert 2 == result.total_qty
      assert Money.add(product.price, product_2.price) == result.total_price
    end
  end
end
