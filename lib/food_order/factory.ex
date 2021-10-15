defmodule FoodOrder.Factory do
  use ExMachina.Ecto, repo: FoodOrder.Repo
  alias FoodOrder.Products.Product

  def product_factory do
    %Product{
      name: Faker.Food.dish() <> " #{:rand.uniform(100)}",
      price: :rand.uniform(10_000),
      description: Faker.Food.description(),
      size: "small"
    }
  end
end
