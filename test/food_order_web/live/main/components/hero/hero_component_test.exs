defmodule FoodOrderWeb.Main.Components.HeroComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  test "should load the load hero information", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert has_element?(view, "#hero-info")
    assert is_there_id_with_text?(view, "#hero-info-text", "Are you hungry?")
    assert has_element?(view, "#hero-info-image")
  end
end
