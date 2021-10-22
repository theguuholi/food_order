defmodule FoodOrderWeb.Products.NewProductComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

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

  defp consume_photos(socket, product) do
    consume_uploaded_entries(socket, :photo, fn meta, entry ->
      dest = Path.join("priv/static/uploads", filename(entry))
      File.cp!(meta.path, dest)
      # Routes.static_path(socket, "/uploads/#{filename(entry)}")
    end)
    {:ok, product}
  end

  defp filename(entry) do
    ext = MIME.extensions(entry.client_type)
    "#{entry.uuid}.#{ext}"
  end

  defp completed_entries(socket) do
    {completed, []} = uploaded_entries(socket, :photo)

    for entry <- completed do
      Routes.static_path(socket, "/uploads/#{filename(entry)}")
    end
  end

  defp save_account(socket, :new, product_parms) do
    product = %Product{socket.assigns.product | photos_url: completed_entries(socket)}

    case Products.create_product(product, product_parms, &consume_photos(socket, &1)) do
      {:ok, product} ->
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
