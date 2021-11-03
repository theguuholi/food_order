import FoodOrder.Factory

for _ <- 0..20, do: insert(:product, %{})

FoodOrder.Accounts.register_user(%{email: "test@test", password: "123123123123"})
