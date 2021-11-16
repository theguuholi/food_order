defmodule FoodOrderWeb.Admin.HeaderMenuComponent do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "test header" do
    setup :register_and_log_in_user

    test "side menu", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/orders")
      assert has_element?(view, "#header-menu")
      assert view |> element("#search") |> render() =~ "Search by Order Number"
    end
  end
end
