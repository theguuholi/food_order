defmodule FoodOrder.Orders.Core.GetOrderByIdAndCustomerId do
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Repo
  import Ecto.Query

  def execute(id, customer_id) do
    Order
    |> where([o], o.id == ^id and o.user_id == ^customer_id)
    |> Repo.one()
  end
end
