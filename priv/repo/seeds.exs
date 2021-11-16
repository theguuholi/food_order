import FoodOrder.Factory
alias FoodOrder.Accounts.User
alias FoodOrder.Repo

for _ <- 0..20, do: insert(:product, %{})

insert(:product, %{})
insert(:product, %{})

%User{}
|> User.registration_changeset(%{
  email: "admin@test",
  password: "123123123123",
  role: "ADMIN"
})
|> Repo.insert!()

user =
  %User{}
  |> User.registration_changeset(%{
    email: "user@test",
    password: "123123123123"
  })
  |> Repo.insert!()

insert(:order, user: user)
insert(:order, user: user)
insert(:order, user: user)
insert(:order, user: user)
