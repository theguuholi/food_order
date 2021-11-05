defmodule FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponentTest do
  use FoodOrderWeb.ConnCase

  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  describe "confirm cart" do
    setup :register_and_log_in_user

    test "should see elements on the page", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, "/")

      {:ok, _view, html} =
        view
        |> element("#food-item-add-#{product.id}", "add")
        |> render_click()
        |> follow_redirect(conn, Routes.main_path(conn, :index))

      assert html =~ "Item added to cart"

      {:ok, view, html} = live(conn, Routes.cart_path(conn, :index))

      assert html =~ "Order Summary"
      assert has_element?(view, "#confirm-order")
      assert has_element?(view, "#confirm-order-summary")
      assert has_element?(view, "#confirm-order-form")

      assert is_there_id_with_text?(
               view,
               "#confirm-order-summary-total-amount",
               Money.to_string(product.price)
             )
    end

    test "should confirm the order", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, "/")

      {:ok, _view, html} =
        view
        |> element("#food-item-add-#{product.id}", "add")
        |> render_click()
        |> follow_redirect(conn, Routes.main_path(conn, :index))

      assert html =~ "Item added to cart"

      {:ok, view, _html} = live(conn, Routes.cart_path(conn, :index))

      {:ok, _, html} =
        view
        |> form("#confirm-order-form", %{})
        |> render_submit()
        |> follow_redirect(conn, Routes.order_path(conn, :index))

      assert html =~ "Order Created with Success!"
    end

    test "should confirm the order with error", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, "/")

      {:ok, _view, html} =
        view
        |> element("#food-item-add-#{product.id}", "add")
        |> render_click()
        |> follow_redirect(conn, Routes.main_path(conn, :index))

      assert html =~ "Item added to cart"

      {:ok, view, _html} = live(conn, Routes.cart_path(conn, :index))

      view
      |> element("#order-item-details-remove-#{product.id}")
      |> render_click()

      {:ok, _, html} =
        view
        |> form("#confirm-order-form", %{})
        |> render_submit()
        |> follow_redirect(conn, Routes.cart_path(conn, :index))

      assert html =~  "Something went wrong please verify your order"
    end
  end
end
