defmodule FoodOrderWeb.CartItems do
  import Phoenix.LiveView
  alias FoodOrder.Accounts

  def mount(_params, session, socket) do
    # cart_id = get_connect_params(socket)["cart_id"]
    socket =
      socket
      |> assign_user(session["user_token"])
      |> create_cart(session["cart_id"])

    {:cont, socket}
  end

  defp assign_user(socket, nil) do
    assign(socket, :current_user, nil)
  end

  defp assign_user(socket, user_token) do
    assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)
  end

  defp create_cart(socket, cart_id) do
      assign(socket, cart_id: cart_id)
      # |> push_event("create-session-id", %{"cartId" => cart_id})
  end
end
