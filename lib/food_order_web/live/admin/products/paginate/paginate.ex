defmodule FoodOrderWeb.Admin.Products.Paginate do
  use FoodOrderWeb, :live_component

  def pagination_link(%{page: page, text: text, socket: socket} = assigns) do
    ~H"""
      <%= live_patch(text, to: Routes.admin_product_path(socket, :index, page: page)) %>
    """
  end
end
