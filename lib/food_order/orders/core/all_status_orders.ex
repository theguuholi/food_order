defmodule FoodOrder.Orders.Core.AllStatusOrders do
  defstruct all: 0, not_started: 0, received: 0, preparing: 0, delivering: 0, delivered: 0

  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Repo
  import Ecto.Query

  def execute do
    %__MODULE__{}
    |> count_all
    |> not_started_status
    |> received_status
    |> preparing_status
    |> delivering_status
    |> delivered_status
  end

  defp count_all(module) do
    result =
      Order
      |> select([o], count(o.id))
      |> Repo.one()

    %__MODULE__{module | all: result}
  end

  defp delivered_status(module) do
    %__MODULE__{module | delivered: filter_status(:DELIVERED)}
  end

  defp not_started_status(module) do
    %__MODULE__{module | not_started: filter_status(:NOT_STARTED)}
  end

  defp delivering_status(module) do
    %__MODULE__{module | delivering: filter_status(:DELIVERING)}
  end

  defp received_status(module) do
    %__MODULE__{module | received: filter_status(:RECEIVED)}
  end

  defp preparing_status(module) do
    %__MODULE__{module | preparing: filter_status(:PREPARING)}
  end

  defp filter_status(status) do
    Order
    |> where([o], o.status == ^status)
    |> select([o], count(o.id))
    |> Repo.one()
  end
end
