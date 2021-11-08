defmodule FoodOrder.Orders.Core.AllStatusOrders do
  defstruct all: 0, not_started: 0, received: 0, preparing: 0, delivering: 0, delivered: 0

  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Repo
  import Ecto.Query
  # @status_values ~w( RECEIVED PREPARING DELIVERING DELIVERED)a

  def execute() do
    %__MODULE__{}
    |> count_all
    |> not_started_status
    |> IO.inspect()
  end

  defp count_all(module) do
    result =
      Order
      |> select([o], count(o.id))
      |> Repo.one()

    %__MODULE__{module | all: result}
  end

  defp not_started_status(module) do
    %__MODULE__{module | not_started: filter_status(:NOT_STARTED)}
  end

  defp filter_status(status) do
    Order
    |> where([o], o.status == ^status)
    |> select([o], count(o.id))
    |> Repo.one()
  end
end
