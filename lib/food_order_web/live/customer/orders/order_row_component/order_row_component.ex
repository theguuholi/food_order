defmodule FoodOrderWeb.Order.OrderRowComponent do
  use FoodOrderWeb, :live_component

  def update(assigns, socket) do
    IO.inspect assigns
    {:ok, assign(socket, assigns)}
  end
end
