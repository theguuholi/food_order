defmodule FoodOrder.Orders.Data.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias FoodOrder.Accounts.User
  alias FoodOrder.Orders.Data.Item

  @status_values ~w(NOT_STARTED RECEIVED PREPARING DELIVERING DELIVERED)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @fields ~w/status/a
  @required ~w/total_price total_quantity user_id status address phone_number/a
  schema "orders" do
    field :total_price, Money.Ecto.Amount.Type
    field :total_quantity, :integer
    field :address, :string
    field :phone_number, :string
    belongs_to :user, User
    has_many :items, Item
    field :status, Ecto.Enum, values: @status_values, default: :NOT_STARTED
    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, @fields ++ @required)
    |> validate_required(@required)
    |> validate_number(:total_quantity, greater_than: 0)
    |> cast_assoc(:items, with: &Item.changeset/2)
  end
end
