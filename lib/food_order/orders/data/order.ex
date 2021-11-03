defmodule FoodOrder.Orders.Data.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias FoodOrder.Accounts.User
  alias FoodOrder.Orders.Data.Item

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :total_price, Money.Ecto.Amount.Type
    field :total_quantity, :integer
    belongs_to :user, User
    has_many :items, Item

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:total_price, :total_quantity])
    |> validate_required([:total_price, :total_quantity])
    |> cast_assoc(:items, with: &Item.changeset/2)
  end
end
