defmodule FoodOrderWeb.Products.NewProductComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"product" => product}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"product" => product}, socket) do
    save_account(socket, socket.assigns.action, product)
  end

  defp save_account(socket, :new, product_parms) do
    case Products.create_product(socket.assigns.product, product_parms) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
