defmodule FoodOrder.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create_query =
      "CREATE TYPE status AS ENUM ('NOT_STARTED', 'RECEIVED', 'PREPARING', 'DELIVERING', 'DELIVERED')"

    drop_query = "DROP TYPE status"

    execute(create_query, drop_query)

    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :total_price, :integer, default: 0
      add :total_quantity, :integer, default: 0
      add :status, :status, default: "NOT_STARTED"

      add :user_id,
          references(:users, on_delete: :nilify_all, on_update: :nilify_all, type: :binary_id),
          null: false

      timestamps()
    end

    create index(:orders, [:user_id])
  end
end
