defmodule FoodOrderWeb.CartItems do
  import Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:cont, assign(socket, user: "user123")}
  end
end
