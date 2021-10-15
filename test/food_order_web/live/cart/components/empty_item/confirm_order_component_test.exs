defmodule FoodOrderWeb.Cart.Components.EmptyCartComponentTest do
  use FoodOrderWeb.ConnCase

  import Phoenix.LiveViewTest

  alias FoodOrderWeb.Cart.Components.EmptyCartComponent

  test "validate empty cart" do
    assert render_component(EmptyCartComponent, %{}) =~ "You probably haven`t ordered a food yet."
  end
end
