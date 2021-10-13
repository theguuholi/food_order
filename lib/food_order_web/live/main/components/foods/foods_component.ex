defmodule FoodOrderWeb.Main.Components.FoodsComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrderWeb.Main.Components.Foods.ItemComponent

  def item(), do: ItemComponent
end
