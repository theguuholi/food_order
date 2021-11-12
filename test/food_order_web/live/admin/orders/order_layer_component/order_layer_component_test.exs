defmodule FoodOrderWeb.Admin.OrderLayerComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "test products" do
    setup :register_and_log_in_user

    test "load board", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/admin/orders")
      assert has_element?(view, "[data-role=order-board][data-id=NOT_STARTED]")

      assert has_element?(
               view,
               "[data-role=order-layer-title][data-id=NOT_STARTED]",
               "Not started"
             )
    end

    test "change card to another place", %{conn: conn} do
      order = insert(:order)
      {:ok, view, _html} = live(conn, "/admin/orders")

      assert has_element?(
               view,
               "[data-role=order-number][data-id=NOT_STARTED-#{order.id}]",
               order.id
             )

      view
      |> element("#NOT_STARTED")
      |> render_hook("dropped", %{
        "orderId" => order.id,
        "orderStatus" => :PREPARING,
        "orderOldStatus" => :NOT_STARTED
      })

      assert has_element?(
               view,
               "[data-role=order-number][data-id=PREPARING-#{order.id}]",
               order.id
             )
    end
  end
end
