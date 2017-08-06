defmodule Bridge.TableSupervisor do
  use Supervisor

  @name Bridge.TableSupervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  @doc """
  Ensure table server exists for the given name.
  """
  def ensure_table(id) do
    if Registry.lookup(Bridge.TableRegistry, id) == [] do
      Supervisor.start_child(@name, [id])
    end
    :ok
  end

  def init(:ok) do
    children = [
      Bridge.Table
    ]
    opts = [strategy: :simple_one_for_one]
    Supervisor.init(children, opts)
  end
end
