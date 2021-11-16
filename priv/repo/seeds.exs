import FoodOrder.Factory
alias FoodOrder.Accounts.User
alias FoodOrder.Repo

for _ <- 0..20, do: insert(:product, %{})

insert(:product, %{})
insert(:product, %{})

insert(:order)
insert(:order)
insert(:order)
insert(:order)

%User{}
|> User.registration_changeset(%{
  email: "test@test",
  password: "123123123123123"
})
|> Repo.insert!()
