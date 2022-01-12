defmodule FoodOrderWeb.Cart.Components.Order.ConfirmOrder.ConfirmOrderComponent do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Orders

  def update(assigns, socket) do
    IO.inspect(assigns, label: "test!")

    {:ok,
     socket
     |> assign(assigns)
     |> assign(is_payment_card: true)
     |> create_stripe_intent(assigns)}
  end

  defp create_stripe_intent(socket, %{current_user: current_user, order: order}) do
    with {:ok, stripe_customer} <-
           Stripe.Customer.create(%{
             email: current_user.email <> ".com",
             name: current_user.email
           }),
         {:ok, payment_intent} <-
           Stripe.PaymentIntent.create(%{
             customer: stripe_customer.id,
             amount: order.total_price.amount,
             currency: order.total_price.currency
           })
           |> IO.inspect() do
      #   # Update the checkout
      #   Checkouts.update_checkout(checkout, %{payment_intent_id: payment_intent.id})

      IO.inspect("here!!")
      assign(socket, :intent, payment_intent)
    else
      _ ->
        IO.inspect "jere!!"
        socket
        |> put_flash(:error, "There was an error with the stripe")
        |> push_redirect(to: "/")
    end
  end

  def handle_event("validate", %{"payment_type" => payment_type}, socket) do
    {:noreply, assign(socket, is_payment_card: payment_type == "card")}
  end

  def handle_event("create_order", params, socket) do
    case Orders.create_order_by_cart(params) do
      {:ok, _order} ->
        socket =
          socket
          |> put_flash(:info, "Order Created with Success!")
          |> push_redirect(to: Routes.customer_order_path(socket, :index))

        {:noreply, socket}

      {:error, _changeset} ->
        socket =
          socket
          |> put_flash(:error, "Something went wrong please verify your order")
          |> push_redirect(to: Routes.cart_path(socket, :index))

        {:noreply, socket}
    end
  end
end
