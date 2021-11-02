defmodule FoodOrderWeb.ModalComponent do
  use FoodOrderWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div
      id={@id}
      class="phx-modal"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target={@myself}
      phx-page-loading>

      <div class="phx-modal-content">
        <%= live_patch raw("&times;"), to: @return_to, class: "phx-modal-close" %>
        <%= live_component @component, @opts %>
      </div>
    </div>
    """
  end

  # coveralls-ignore-start
  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
  # coveralls-ignore-stop
end
