defmodule FoodOrderWeb.Admin.OrderLayerComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "load board", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/admin/orders")
    assert has_element?(view, "#order-board-123")
    assert has_element?(view, "#order-layer-title-1", "Backlog")
  end
end
