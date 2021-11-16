defmodule FoodOrderWeb.Products.NewProductComponentTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test products" do
    setup :register_and_log_in_user

    test "should open modal", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/products")

      view
      |> element("[data-role=add-new-product]", "New")
      |> render_click()

      assert_patched(view, "/admin/products/new")

      assert has_element?(view, "#product-form_name")
      assert has_element?(view, "#product-form_description")
      assert has_element?(view, "#product-form_price")
      assert has_element?(view, "#product-form_size")

      view
      |> element(".phx-modal-close")
      |> render_click()

      assert_patched(view, "/admin/products")
    end

    test "should cancel upload", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/products/new")

      upload =
        file_input(view, "#product-form", :photo, [
          %{
            last_modified: 1_594_171_879_000,
            name: "myfile.jpeg",
            content: " ",
            type: "image/jpeg"
          }
        ])

      assert render_upload(upload, "myfile.jpeg") =~ "100%"
      ref = "#entry-cancel-#{hd(upload.entries)["ref"]}"
      assert has_element?(view, ref)
      assert element(view, ref) |> render_click()
      refute has_element?(view, ref)
    end

    test "should create new product", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/products/new")

      upload =
        file_input(view, "#product-form", :photo, [
          %{
            last_modified: 1_594_171_879_000,
            name: "myfile.jpeg",
            content: " ",
            type: "image/jpeg"
          }
        ])

      assert view
             |> form("#product-form", product: %{})
             |> render_change() =~ "can&#39;t be blank"

      assert render_upload(upload, "myfile.jpeg") =~ "100%"

      {:ok, _, html} =
        view
        |> form("#product-form",
          product: %{name: "test123", price: "122", description: "pumpkin", size: "small"}
        )
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

      assert html =~ "Product created successfully"
      assert html =~ "test123"
    end

    test "should return errors when try to create product", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/products/new")

      assert view
             |> form("#product-form", product: %{})
             |> render_submit() =~
               "can&#39;t be blank"
    end
  end
end
