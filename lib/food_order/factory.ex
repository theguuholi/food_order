defmodule FoodOrder.Factory do
  use ExMachina.Ecto, repo: FoodOrder.Repo
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Products.Product
  alias FoodOrder.Accounts.User
  alias FoodOrder.Repo

  defp product do
    %Product{
      name: Faker.Food.dish() <> " #{:rand.uniform(1000)}",
      price: :rand.uniform(10_000),
      description: Faker.Food.description(),
      size: "small"
    }
  end

  def product_map do
    %{
      name: Faker.Food.dish() <> " #{:rand.uniform(1000)}",
      price: :rand.uniform(10_000),
      description: Faker.Food.description(),
      size: "small"
    }
  end

  def product_factory do
    product()
  end

  def order_factory() do
    user =
      %User{}
      |> User.registration_changeset(%{
        email: "test-#{:rand.uniform(10_000)}@test.com",
        password: "123123123123123"
      })
      |> Repo.insert!()

    product_1 = %Product{} |> Product.changeset(product_map()) |> Repo.insert!()
    product_2 = %Product{} |> Product.changeset(product_map()) |> Repo.insert!()

    total_price =
      product_1.price
      |> Money.add(product_1.price)
      |> Money.add(product_2.price)

    %Order{
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
    }
  end
end
