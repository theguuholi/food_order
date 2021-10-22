defmodule FoodOrderWeb.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Products.NewProductComponent
  alias FoodOrderWeb.Products.ProductItemComponent

  @impl true
  def mount(_assign, _session, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products), temporary_assigns: [products: []]}
  end

  def product_item, do: ProductItemComponent
  def new_product, do: NewProductComponent

  @impl true
  def handle_info({:product_created, product}, socket) do
    {:noreply, update(socket, :products, &[product | &1])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Account")
    |> assign(:product, %Product{})
  end
end
