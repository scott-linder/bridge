defmodule Bridge.Table do
  use GenServer

  def start_link(_opts, id) do
    GenServer.start_link(__MODULE__, :ok, name: via_tuple(id))
  end

  defp via_tuple(id) do
    {:via, Registry, {Bridge.TableRegistry, id}}
  end

  def init(:ok) do
    {:ok, []}
  end
end
