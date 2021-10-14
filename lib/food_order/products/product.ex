defmodule FoodOrder.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :description, :string
    field :name, :string
    field :price, Money.Ecto.Amount.Type
    field :size, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :size, :description])
    |> validate_required([:name, :price, :size, :description])
    |> unique_constraint(:name)
  end
end
