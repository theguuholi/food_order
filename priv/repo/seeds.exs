import FoodOrder.Factory

for _ <- 0..20, do: insert(:product, %{})

product_1 = insert(:product, %{})
product_2 = insert(:product, %{})

insert(:order)
