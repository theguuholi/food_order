defmodule FoodOrder.Orders.Core.CreateOrderByCartTest do
  use FoodOrder.DataCase
  import FoodOrder.AccountsFixtures
  import FoodOrder.ProductsFixtures

  alias FoodOrder.Carts
  alias FoodOrder.Orders.Core.CreateOrderByCart

  describe "create order" do
    test "create_order_by_cart with success" do
      product = product_fixture()
      user = user_fixture()
      assert :ok == Carts.create_session(user.id)
      assert :ok == Carts.update_cart(product, user.id)
      assert 1 == Carts.get_cart(user.id).total_qty

      payload = %{
        "address" => "123",
        "current_user" => user.id,
        "phone_number" => "123"
      }

      {:ok, result} = CreateOrderByCart.execute(payload)
      assert 1 == result.total_quantity
      assert 0 == Carts.get_cart(user.id).total_qty
    end

    test "create_order_by_cart with error" do
      user = user_fixture()
      assert :ok == Carts.create_session(user.id)

      payload = %{
        "address" => "123",
        "current_user" => user.id,
        "phone_number" => "123"
      }

      {:error, changeset} = CreateOrderByCart.execute(payload)
      assert "must be greater than 0" in errors_on(changeset).total_quantity
    end
  end
end
