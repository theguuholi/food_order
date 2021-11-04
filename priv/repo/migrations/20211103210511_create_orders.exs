defmodule FoodOrder.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :total_price, :integer, default: 0
      add :total_quantity, :integer, default: 0
      add :user_id, references(:users, on_delete: :nilify_all, on_update: :nilify_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:orders, [:user_id])
  end
end
