defmodule FoodOrderWeb.Cart.Components.Order.OrderItem.OrderItemComponentTest do
  use FoodOrderWeb.ConnCase

  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  describe "should validate cart" do
    setup :register_and_log_in_user

    test "validate order item", %{conn: conn} do
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

      assert has_element?(view, "#order-item-#{product.id}")
      assert has_element?(view, "#order-item-details-#{product.id}")

      assert is_there_id_with_text?(view, "#order-item-details-name-#{product.id}", product.name)
      assert is_there_id_with_text?(view, "#order-item-details-size-#{product.id}", product.size)

      assert is_there_id_with_text?(
               view,
               "[data-test-id=order-item-details-amount-#{product.id}]",
               "1 Item(s)"
             )

      assert is_there_id_with_text?(
               view,
               "#order-item-details-price-#{product.id}",
               Money.to_string(product.price)
             )
    end

    test "should dec element ", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, "/")

      {:ok, _view, html} =
        view
        |> element("#food-item-add-#{product.id}", "add")
        |> render_click()
        |> follow_redirect(conn, Routes.main_path(conn, :index))

      assert html =~ "Item added to cart"

      {:ok, view, _html} = live(conn, Routes.cart_path(conn, :index))

      assert has_element?(view, "#order-item-#{product.id}")
      assert has_element?(view, "#order-item-details-#{product.id}")

      view
      |> element("#order-item-details-inc-#{product.id}", "+")
      |> render_click()

      view
      |> element("#order-item-details-inc-#{product.id}", "+")
      |> render_click()

      assert render(view) =~ "3 Item(s)"

      view
      |> element("#order-item-details-dec-#{product.id}", "-")
      |> render_click()

      assert render(view) =~ "2 Item(s)"
    end

    test "should inc element ", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, "/")

      {:ok, _view, html} =
        view
        |> element("#food-item-add-#{product.id}", "add")
        |> render_click()
        |> follow_redirect(conn, Routes.main_path(conn, :index))

      assert html =~ "Item added to cart"

      {:ok, view, _html} = live(conn, Routes.cart_path(conn, :index))

      assert has_element?(view, "#order-item-#{product.id}")
      assert has_element?(view, "#order-item-details-#{product.id}")

      view
      |> element("#order-item-details-inc-#{product.id}", "+")
      |> render_click()

      assert render(view) =~ "2 Item(s)"
    end

    test "should remove element ", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, "/")

      {:ok, _view, html} =
        view
        |> element("#food-item-add-#{product.id}", "add")
        |> render_click()
        |> follow_redirect(conn, Routes.main_path(conn, :index))

      assert html =~ "Item added to cart"

      {:ok, view, _html} = live(conn, Routes.cart_path(conn, :index))

      assert has_element?(view, "#order-item-#{product.id}")
      assert has_element?(view, "#order-item-details-#{product.id}")

      view
      |> element("#order-item-details-remove-#{product.id}")
      |> render_click()

      assert render(view) =~ "$0.00"
    end
  end
end
