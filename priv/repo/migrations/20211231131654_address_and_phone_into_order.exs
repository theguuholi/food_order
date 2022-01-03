defmodule FoodOrder.Repo.Migrations.AddressAndPhoneIntoOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :address, :string, null: false
      add :phone_number, :string, null: false
    end
  end
end
