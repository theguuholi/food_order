alias FoodOrder.Products

for _ <- 1..100 do
  Products.create_product(%{
    "name" => Faker.Food.dish() <> "#{:rand.uniform(10_000)}",
    "price" => :rand.uniform(10_000),
    "description" => Faker.Food.description(),
    "size" => "small"
  })
end
