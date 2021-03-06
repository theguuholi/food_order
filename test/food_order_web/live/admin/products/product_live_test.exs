defmodule FoodOrderWeb.Admin.Products.ProductLiveTest do
  use FoodOrderWeb.ConnCase

  import FoodOrder.Factory
  import Phoenix.LiveViewTest

  alias FoodOrder.Products

  describe "test products" do
    setup :register_and_log_in_user

    test "load table elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/products")

      assert has_element?(view, "[data-role=product-section]")
      assert has_element?(view, "[data-role=product-table]")
      assert has_element?(view, "[data-role=head-name]", "Name")
      assert has_element?(view, "[data-role=head-price]", "Price")
      assert has_element?(view, "[data-role=head-size]", "Size")
      assert has_element?(view, "[data-role=head-actions]", "Actions")
      assert has_element?(view, "[data-role=add-new-product]", "New")
    end

    test "filter by name", %{conn: conn} do
      [product_1 | _] = for _ <- 1..10, do: insert(:product)
      {:ok, view, _} = live(conn, "/admin/products")
      assert has_element?(view, "#product-item-#{product_1.id}", product_1.name)

      letters = product_1.name |> String.slice(1..2)

      view
      |> form("#filter-by-name", %{name: letters})
      |> render_submit()

      assert has_element?(view, "#product-item-#{product_1.id}", product_1.name)
    end

    test "sorting using url", %{conn: conn} do
      for _ <- 1..10, do: insert(:product)

      filter = [
        paginate: %{page: 2, per_page: 2},
        sort: %{sort_by: :name, sort_order: :desc},
        name: ""
      ]

      [product_1, product_2] = Products.list_products(filter)

      {:ok, view, _} =
        live(conn, "/admin/products?page=2&per_page=2&sort_by=name&sort_order=desc&name=")

      assert has_element?(view, "#product-item-#{product_1.id}", product_1.name)
      assert has_element?(view, "#product-item-#{product_2.id}", product_2.name)
    end

    test "clicking sorting by patches", %{conn: conn} do
      {:ok, view, _} = live(conn, "/admin/products")

      view
      |> element("[data-role=sort][data-id=name]", "Name")
      |> render_click()

      assert_patched(view, "/admin/products?page=1&per_page=4&sort_by=name&sort_order=asc&name=")

      view
      |> element("[data-role=sort][data-id=name]", "Name")
      |> render_click()

      assert_patched(view, "/admin/products?page=1&per_page=4&sort_by=name&sort_order=desc&name=")
    end

    test "clicking next, previous, and page a", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/products?page=1&per_page=1")

      view
      |> element("[data-role=paginate][data-id=next]", ">>")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=2&per_page=1&sort_by=updated_at&name=&sort_order=desc"
      )

      view
      |> element("[data-role=paginate][data-id=previous]", "<<")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=1&per_page=1&sort_by=updated_at&name=&sort_order=desc"
      )

      view
      |> element("[data-role=paginate][data-id=3]", "3")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=3&per_page=1&sort_by=updated_at&name=&sort_order=desc"
      )
    end

    test "test pagination using url_params", %{conn: conn} do
      [product_1, product_2] = for _ <- 1..2, do: insert(:product)

      {:ok, view, _html} = live(conn, "/admin/products?page=1&per_page=1")

      assert has_element?(view, "#product-item-#{product_1.id}")
      refute has_element?(view, "#product-item-#{product_2.id}")

      {:ok, view, _html} = live(conn, "/admin/products?page=2&per_page=1")

      assert has_element?(view, "#product-item-#{product_2.id}")
      refute has_element?(view, "#product-item-#{product_1.id}")
    end

    test "trigger new product", %{conn: conn} do
      product = insert(:product)

      {:ok, view, _html} = live(conn, "/admin/products")

      assert has_element?(view, "#product-item-#{product.id}")
      assert has_element?(view, "#product-item-#{product.id}", product.name)
      assert has_element?(view, "#product-item-#{product.id}", Money.to_string(product.price))
      assert has_element?(view, "#product-item-#{product.id}", product.size)

      new_product = %{
        id: "123",
        name: "pumpkin",
        size: "small",
        price: Money.new(100),
        photos_url: [],
        description: "aaa"
      }

      send(view.pid, {:product_created, new_product})

      assert has_element?(view, "#product-item-#{new_product.id}")
      assert has_element?(view, "#product-item-#{new_product.id}", new_product.name)

      assert has_element?(
               view,
               "#product-item-#{new_product.id}",
               Money.to_string(new_product.price)
             )

      assert has_element?(view, "#product-item-#{new_product.id}", new_product.size)
    end
  end
end
