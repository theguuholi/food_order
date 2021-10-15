defmodule FoodOrderWeb.Cart.Components.OrderComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "validate order component", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/cart")
    assert is_there_id_with_text?(view, "#order-info", "Order Summary")
  end
end
