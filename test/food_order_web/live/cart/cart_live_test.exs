defmodule FoodOrderWeb.CartLiveTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "should validate cart" do
    setup :register_and_log_in_user

    test "validate cart page", %{conn: conn} do
      {:ok, page_live, disconnected_html} = live(conn, "/cart")
      assert disconnected_html =~ "You probably haven`t ordered a food yet."
      render(page_live) =~ "You probably haven`t ordered a food yet."
    end
  end
end
