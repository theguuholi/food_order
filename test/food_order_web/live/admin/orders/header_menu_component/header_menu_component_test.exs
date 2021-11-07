defmodule FoodOrderWeb.Admin.HeaderMenuComponent do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "side menu", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/orders")
    assert has_element?(view, "#header-menu")
    assert view |> element("#search") |> render() =~ "Search by Order Number"
  end
end
