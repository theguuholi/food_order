defmodule FoodOrderWeb.CartItems do
  import Phoenix.LiveView
  alias FoodOrder.Carts

  def mount(_params, _session, socket) do
    user =
      if info = get_connect_info(socket) do
        ip =
          info.peer_data.address
          |> Tuple.to_list()
          |> Enum.map(&Integer.to_string/1)
          |> List.to_string()

        Carts.create_session(ip)
        ip
      else
        Carts.create_session("user123")
        "user123"
      end

    {:cont, assign(socket, user: user)}
  end
end
