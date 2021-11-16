defmodule FoodOrderWeb.AdminPermissions do
  import Phoenix.LiveView
  alias FoodOrder.Accounts
  require Logger

  def mount(_params, session, socket) do
    assign_user(socket, session["user_token"])
  end

  defp assign_user(socket, nil) do
    {:halt,
     socket
     |> put_flash(:error, "You must be logged in")
     |> redirect(to: "/")}
  end

  defp assign_user(socket, user_token) do
    current_user = Accounts.get_user_by_session_token(user_token)

    if current_user.role != :ADMIN do
      {:halt,
       socket
       |> put_flash(:error, "You don`t have permissions to access this page")
       |> redirect(to: "/")}
    else
      {:cont, assign_new(socket, :current_user, fn -> current_user end)}
    end
  end
end
