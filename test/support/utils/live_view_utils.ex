defmodule FoodOrder.Utils.LiveViewUtils do
  import Phoenix.LiveViewTest

  def is_there_id_with_text?(view, id, text) do
    view |> element(id) |> render =~ text
  end
end
