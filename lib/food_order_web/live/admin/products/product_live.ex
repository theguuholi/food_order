defmodule FoodOrderWeb.Admin.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Admin.Products.FilterByName
  alias FoodOrderWeb.Admin.Products.NewProductComponent
  alias FoodOrderWeb.Admin.Products.Paginate
  alias FoodOrderWeb.Admin.Products.ProductItemComponent

  @impl true
  def mount(_assign, _session, socket) do
    {:ok, socket, temporary_assigns: [products: []]}
  end

  @impl true
  def handle_params(params, _, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "4")
    paginate = %{page: page, per_page: per_page}
    products = Products.list_products(paginate: paginate)

    {:noreply,
     socket
     |> assign(products: products, paginate: paginate)
     |> apply_action(socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info({:product_created, product}, socket) do
    {:noreply, update(socket, :products, &[product | &1])}
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
