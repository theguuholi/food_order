defmodule FoodOrderWeb.Cart.Components.OrderComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "should validate cart" do
    setup :register_and_log_in_user

    test "validate items in confirm order", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, "/")

      {:ok, _view, html} =
        view
        |> element("#food-item-add-#{product.id}", "add")
        |> render_click()
        |> follow_redirect(conn, Routes.main_path(conn, :index))

      assert html =~ "Item added to cart"

      {:ok, _view, html} = live(conn, Routes.cart_path(conn, :index))

      assert html =~ "Order Summary"
      {:ok, view, _html} = live(conn, "/cart")
      assert is_there_id_with_text?(view, "#order-info", "Order Summary")
    end
  end
end
