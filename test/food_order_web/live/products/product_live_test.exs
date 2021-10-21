defmodule FoodOrderWeb.FoodOrderWeb.ProductItemComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/products")
    render(view) =~ "Name"
  end
end
