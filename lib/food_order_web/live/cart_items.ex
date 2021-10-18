defmodule FoodOrderWeb.CartItems do
  import Phoenix.LiveView
  alias FoodOrder.Carts

  def mount(_params, _session, socket) do
    Carts.create_session("user123")
    {:cont, assign(socket, user: "user123")}
  end
end
