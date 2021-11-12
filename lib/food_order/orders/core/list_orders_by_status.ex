defmodule FoodOrder.Orders.Core.ListOrdersByStatus do
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Repo
  import Ecto.Query

  def execute(status) do
    Order
    |> where([o], o.status == ^status)
    |> order_by([o], desc: o.inserted_at)
    |> preload([o], [:user, items: [:product]])
    |> Repo.all()
  end
end
