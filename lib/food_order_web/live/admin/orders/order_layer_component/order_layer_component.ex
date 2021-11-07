defmodule FoodOrderWeb.Admin.Orders.OrderLayerComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrderWeb.Orders.OrderLayer.CardComponent

  def card, do: CardComponent
end
