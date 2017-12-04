defmodule Portal do
  defstruct [:left, :right]

  @doc """
  Starts transferring 'data' from 'left' to 'right'
  """
  def transfer(left, right, data) do
    # first add all the data to the left portal
    for item <- data do
      Portal.Door.push(left, item)
    end

    # returns the portal struct we'll use next
    %Portal{left: left, right: right}
  end

  def push_right(portal) do
    # See if we can pop data from left. If so, push the
    # popped data to the right. Otherwise, do nothing.
    case Portal.Door.pop(portal.left) do
      :error -> :ok
      {:ok, h} -> Portal.Door.push(portal.right, h)
    end

    portal
  end

  def shoot(color) do
    Supervisor.start_child(Portal.Supervisor, [color])
  end
end

defimpl Inspect, for: Portal do
  def inspect(%Portal{left: left, right: right}, _) do
    left_door = inspect(left)
    right_door = inspect(right)

    left_data = inspect(Enum.reverse(Portal.Door.get(left)))
    right_data = inspect(Portal.Door.get(right))

    max = max(String.length(left_door), String.length(left_data))

    """
    #Portal<
      #{String.rjust(left_door, max)} <=> #{right_door}
      #{String.rjust(left_data, max)} <=> #{right_data}
    """
  end
end