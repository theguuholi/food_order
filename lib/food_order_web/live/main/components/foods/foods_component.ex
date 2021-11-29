defmodule FoodOrderWeb.Main.Components.FoodsComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  alias FoodOrderWeb.Main.Components.Foods.ItemComponent

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(page: 1, per_page: 8)
     |> assign_products()}
  end

  def item, do: ItemComponent

  defp assign_products(socket) do
    paginate = [{:paginate, %{page: socket.assigns.page, per_page: socket.assigns.per_page}}]
    products = Products.list_products(paginate)
    assign(socket, products: products)
  end

  @impl true
  def handle_event("load_products", _, socket) do
    {:noreply,
     socket
     |> update(:page, &(&1 + 1))
     |> assign_products}
  end
end
