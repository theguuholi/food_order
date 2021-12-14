defmodule FoodOrderWeb.Plug.CreateSession do
  require Logger

  import Plug.Conn

  alias FoodOrder.Accounts
  alias FoodOrder.Carts

  def init(_params), do: nil

  def call(conn, _params) do
    user_token = get_session(conn, :user_token)
    cart_id = get_cart_id(conn, user_token)

    Logger.info(message: "Create Session Cart", cart_id: cart_id)
    Carts.create_session(cart_id)

    conn
    |> put_session("cart_id", cart_id)
    |> assign(:cart_id, cart_id)
  end

  defp get_cart_id(conn, nil) do
    cart_id = conn.req_cookies["cart_id"]
    (cart_id && cart_id) || Ecto.UUID.generate()
  end

  defp get_cart_id(_conn, user_token) do
    Accounts.get_user_by_session_token(user_token).id
  end
end
