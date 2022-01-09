defmodule FoodOrderWeb.Admin.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Admin.Products.FilterByName
  alias FoodOrderWeb.Admin.Products.NewProductComponent
  alias FoodOrderWeb.Admin.Products.Paginate
  alias FoodOrderWeb.Admin.Products.ProductItemComponent
  alias FoodOrderWeb.Admin.Products.SortHeader

  @impl true
  def mount(_assign, _session, socket) do
    {:ok, socket, temporary_assigns: [products: []]}
  end

  @impl true
  def handle_params(params, _, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "4")
    name = params["name"] || ""
    paginate = %{page: page, per_page: per_page}
    sort_by = (params["sort_by"] || "updated_at") |> String.to_atom()
    sort_order = (params["sort_order"] || "desc") |> String.to_atom()
    sort = %{sort_by: sort_by, sort_order: sort_order}

    products = Products.list_products(paginate: paginate, sort: sort, name: name)
    options = Map.merge(paginate, sort)
    assigns = [products: products, options: options, name: name, loading: false]

    {:noreply,
     socket
     |> assign(assigns)
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

  @impl true
  def handle_info({:run_list_product_search, name, options}, socket) do
    paginate = %{page: options.page, per_page: options.per_page}
    sort = %{sort_by: options.sort_by, sort_order: options.sort_order}
    products = Products.list_products(paginate: paginate, sort: sort, name: name)

    case products do
      [] ->
        socket =
          socket
          |> put_flash(:info, "There is no product with: \"#{name}\"")
          |> assign(products: [], loading: false)

        {:noreply, socket}

      products ->
        socket =
          socket
          |> assign(products: products)
          |> assign(loading: false)

        {:noreply, socket}
    end
  end

  @impl true
  def handle_event("filter-by-name", %{"name" => name}, socket) do
    options = socket.assigns.options

    socket =
      socket
      |> assign(name: name)
      |> assign(products: [])
      |> assign(loading: true)

    send(self(), {:run_list_product_search, name, options})
    {:noreply, socket}
  end
end
