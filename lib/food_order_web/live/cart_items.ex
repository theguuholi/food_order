defmodule FoodOrderWeb.CartItems do
  import Phoenix.LiveView
  alias FoodOrder.Accounts
  alias FoodOrder.Carts
  require Logger


  def mount(_params, session, socket) do
    socket =
      socket
      |> assign_user(session["user_token"])
      |> create_cart()

    {:cont, socket}
  end

  defp assign_user(socket, nil) do
    assign(socket, :current_user, nil)
  end

  defp assign_user(socket, user_token) do
    assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)
  end

  defp create_cart(socket) do
    current_user = socket.assigns.current_user

    if current_user != nil do
      Logger.info([message: "Create Session Cart", cart_id: current_user.id])
      Carts.create_session(current_user.id)
      assign(socket, cart_id: current_user.id)
    else
      cart_id = get_ip(socket)
      Logger.info([message: "Create Session Cart Using IP", cart_id: cart_id])
      Carts.create_session(cart_id)
      assign(socket, cart_id: cart_id)
    end
  end

  # coveralls-ignore-start
  defp get_ip(socket) do
    if Mix.env() != :test do
      if info = get_connect_info(socket) do
        ip =
          info.peer_data.address
          |> Tuple.to_list()
          |> Enum.map(&Integer.to_string/1)
          |> List.to_string()

        ip
      end
    else
      "user123"
    end
  end

  # coveralls-ignore-stop
end
