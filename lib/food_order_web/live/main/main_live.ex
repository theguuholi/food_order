defmodule FoodOrderWeb.MainLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Main.Components.FoodsComponent
  alias FoodOrderWeb.Main.Components.HeroComponent

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def hero, do: HeroComponent
  def foods, do: FoodsComponent
end
