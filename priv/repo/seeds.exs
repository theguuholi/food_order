import FoodOrder.Factory
alias FoodOrder.Repo
alias FoodOrder.Orders.Data.Order

[product_1, product_2 | _rest] = for _ <- 0..20, do: insert(:product, %{})

{:ok, user} = FoodOrder.Accounts.register_user(%{email: "test@test", password: "123123123123"})

total_price =
  product_1.price
  |> Money.add(product_1.price)
  |> Money.add(product_2.price)

Order.changeset(%Order{}, %{
  user_id: user.id,
  items: [
    %{
      quantity: 2,
      product_id: product_1.id
    },
    %{
      quantity: 1,
      product_id: product_2.id
    }
  ],
  total_quantity: 3,
  total_price: total_price
})
|> Repo.insert!()
|> IO.inspect()
