defmodule FoodOrderWeb.Admin.Products.Paginate do
  use FoodOrderWeb, :live_component

  def pagination_link(%{page: page, options: options, text: text, socket: socket} = assigns) do
    ~H"""
      <%= live_patch(text, to: Routes.admin_product_path(socket, :index,
                            page: page,
                            per_page: options.per_page,
                            sort_by: options.sort_by,
                            sort_order: options.sort_order)) %>
    """
  end
end
