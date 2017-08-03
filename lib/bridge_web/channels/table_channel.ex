defmodule BridgeWeb.TableChannel do
  use Phoenix.Channel

  def join("table:" <> table_id, _params, socket) do
    send self(), :after_join
    {:ok, assign(socket, :table_id, table_id)}
  end

  def handle_info(:after_join, socket) do
    push socket, "user_id", %{user_id: socket.assigns[:user_id]}
    {:noreply, socket}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end
end
