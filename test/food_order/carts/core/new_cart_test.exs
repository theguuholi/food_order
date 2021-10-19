defmodule FoodOrder.Carts.Core.NewCartTest do
  use FoodOrder.DataCase
  alias FoodOrder.Carts.Data.Cart
  alias FoodOrder.Carts.Core.NewCart

  describe "new cart" do
    test "should create a new cart" do
      assert %Cart{} == NewCart.new()
    end
  end
end
