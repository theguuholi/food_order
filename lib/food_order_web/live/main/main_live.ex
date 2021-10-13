defmodule FoodOrderWeb.MainLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Main.Components.HeroComponent
  alias FoodOrderWeb.Main.Components.FoodsComponent

  def mount(_assign, _session, socket) do
    {:ok, socket}
  end

  def hero, do: HeroComponent
  def foods, do: FoodsComponent
end
