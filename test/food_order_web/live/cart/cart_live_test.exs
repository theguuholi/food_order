defmodule FoodOrderWeb.CartLiveTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "validate cart page", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/cart")
    assert disconnected_html =~ "Order Summary"
    render(page_live) =~ "Order Summary"
  end
end
