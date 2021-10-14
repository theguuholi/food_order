defmodule FoodOrderWeb.MainLiveTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "All Foods"
    render(page_live) =~ "All Foods"
  end
end
