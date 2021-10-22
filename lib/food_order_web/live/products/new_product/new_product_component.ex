defmodule FoodOrderWeb.Products.NewProductComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)

    socket =
      allow_upload(socket, :photo,
        accept: ~w/.png .jpeg .jpg .svg/,
        max_entries: 1,
        max_file_size: 10_000_000
      )

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
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

  @impl true
  def handle_event("cancel-img", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :photo, ref)}
  end
end
