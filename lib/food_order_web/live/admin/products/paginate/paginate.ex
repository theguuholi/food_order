defmodule FoodOrderWeb.Admin.Products.Paginate do
  use FoodOrderWeb, :live_component

  def pagination_link(
        %{page: page, options: options, text: text, data_id: data_id, name: name, socket: socket} =
          assigns
      ) do
    ~H"""
      <%= live_patch(text, to: Routes.admin_product_path(socket, :index,
                            page: page,
                            per_page: options.per_page,
                            sort_by: options.sort_by,
                            name: name,
                            sort_order: options.sort_order), "data-role": "paginate", "data-id": data_id) %>
    """
  end
end
