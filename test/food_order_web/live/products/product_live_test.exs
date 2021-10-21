defmodule FoodOrderWeb.Products.ProductItemComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/products")
    render(view) =~ "Name"
    assert has_element?(view, "#add-new-product", "New")
  end
end
