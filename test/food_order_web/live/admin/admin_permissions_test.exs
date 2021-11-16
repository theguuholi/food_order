defmodule FoodOrderWeb.Admin.AdminPermissionsTest do
  use FoodOrderWeb.ConnCase

  import FoodOrder.AccountsFixtures
  import Phoenix.LiveViewTest

  test "send message your must be logged when try to access admin route as a normal user", %{
    conn: conn
  } do
    user = user_customer_fixture()
    token = FoodOrder.Accounts.generate_user_session_token(user)

    conn =
      conn
      |> Phoenix.ConnTest.init_test_session(%{})
      |> Plug.Conn.put_session(:user_token, token)

    {:error, {:redirect, %{to: to}}} = live(conn, "/admin/orders")
    assert to == "/"
  end

  test "send message your must be logged when try to access admin route", %{conn: conn} do
    {:error, {:redirect, %{to: to}}} = live(conn, "/admin/orders")
    assert to == "/"
  end

  test "send message your must be logged when try to access customer route", %{conn: conn} do
    {:error, {:redirect, %{to: to}}} = live(conn, "/customer/orders")
    assert to == "/"
  end
end
