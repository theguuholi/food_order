defmodule FoodOrderWeb.Cart.Components.Order.OrderItem.OrderItemComponentTest do
  use FoodOrderWeb.ConnCase

  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  alias FoodOrder.Carts

  test "validate order item", %{conn: conn} do
    product = insert(:product)
    Carts.create_session("user123")
    Carts.update_cart(product, "user123")
    {:ok, view, _html} = live(conn, "/cart")

    assert has_element?(view, "#order-item-#{product.id}")
    assert has_element?(view, "#order-item-details-#{product.id}")

    assert is_there_id_with_text?(view, "#order-item-details-name-#{product.id}", product.name)
    assert is_there_id_with_text?(view, "#order-item-details-size-#{product.id}", product.size)
    assert is_there_id_with_text?(view, "#order-item-details-amount-#{product.id}", "1 Item(s)")

    assert is_there_id_with_text?(
             view,
             "#order-item-details-price-#{product.id}",
             Money.to_string(product.price)
           )
  end

  test "should dec element ", %{conn: conn} do
    product = insert(:product)
    Carts.create_session("user123")
    Carts.update_cart(product, "user123")
    {:ok, view, _html} = live(conn, "/cart")

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
    Carts.create_session("user123")
    Carts.update_cart(product, "user123")
    {:ok, view, _html} = live(conn, "/cart")

    assert has_element?(view, "#order-item-#{product.id}")
    assert has_element?(view, "#order-item-details-#{product.id}")

    view
    |> element("#order-item-details-inc-#{product.id}", "+")
    |> render_click()

    assert render(view) =~ "2 Item(s)"
  end

  test "should remove element ", %{conn: conn} do
    product = insert(:product)
    Carts.create_session("user123")
    Carts.update_cart(product, "user123")
    {:ok, view, _html} = live(conn, "/cart")

    assert has_element?(view, "#order-item-#{product.id}")
    assert has_element?(view, "#order-item-details-#{product.id}")

    view
    |> element("#order-item-details-remove-#{product.id}")
    |> render_click()

    assert render(view) =~ "$0.00"
  end
end
