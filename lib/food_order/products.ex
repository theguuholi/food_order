defmodule FoodOrder.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias FoodOrder.Repo

  alias FoodOrder.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:product_created)
  end

  def create_product(product, attrs \\ %{}, fun) do
    product
    |> Product.changeset(attrs)
    |> Repo.insert()
    |> after_save(fun)
    |> broadcast(:product_created)
  end

  defp after_save({:ok, product}, fun) do
    {:ok, _p} = fun.(product)
  end

  defp after_save(err, _), do: err

  def subscribe, do: Phoenix.PubSub.subscribe(FoodOrder.PubSub, "products")

  def broadcast({:error, _} = err, _e), do: err

  def broadcast({:ok, product} = result, event) do
    Phoenix.PubSub.broadcast(FoodOrder.PubSub, "products", {event, product})
    result
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end
end
