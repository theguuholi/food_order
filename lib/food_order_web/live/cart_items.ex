defmodule FoodOrderWeb.CartItems do
  import Phoenix.LiveView
  alias FoodOrder.Accounts
  alias FoodOrder.Carts

  def mount(_params, %{"user_token" => user_token}, socket) do
    socket =
      assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)

    Carts.create_session(socket.assigns.current_user.id)

    {:cont, socket}
  end

  def mount(_params, _session, socket) do
    user =
      cond do
        Mix.env() == :test ->
          %{id: "user123"}

        info = get_connect_info(socket) ->
          ip =
            info.peer_data.address
            |> Tuple.to_list()
            |> Enum.map(&Integer.to_string/1)
            |> List.to_string()

          Carts.create_session(ip)
          %{id: ip}

        true ->
          Carts.create_session("user123")
          %{id: "user123"}
      end

    {:cont, assign(socket, current_user: user)}
  end
end
