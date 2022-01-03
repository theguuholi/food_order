defmodule FoodOrderWeb.Admin.Products.SortHeader do
  use FoodOrderWeb, :live_component

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_color(assigns)
     |> assign_icon_name(assigns)}
  end

  defp assign_color(socket, %{sort_by: sort_by, options: %{sort_by: sort_by_options}}) do
    if sort_by == sort_by_options do
      assign(socket, color: "#fe5f1e")
    else
      assign(socket, color: "#ccc")
    end
  end

  defp assign_icon_name(socket, %{options: %{sort_order: sort_order}}) do
    if sort_order == :desc do
      assign(socket, icon: "sort-descending.html")
    else
      assign(socket, icon: "sort-ascending.html")
    end
  end
end
