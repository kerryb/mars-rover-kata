defmodule MarsRover.Rover do
  @enforce_keys [:x, :y, :direction]
  defstruct [:x, :y, :direction]

  def new do
    %__MODULE__{x: 0, y: 0, direction: :north}
  end

  @turn_right %{north: :east, east: :south, south: :west, west: :north}
  def command(rover, "R") do
    %{rover | direction: @turn_right[rover.direction]}
  end

  @turn_left %{north: :west, east: :north, south: :east, west: :south}
  def command(rover, "L") do
    %{rover | direction: @turn_left[rover.direction]}
  end

  def command(rover, "M") do
    %{rover | x: new_x(rover), y: new_y(rover)}
  end

  defp new_x(%{x: x, direction: :east}), do: x + 1
  defp new_x(%{x: x, direction: :west}), do: x - 1
  defp new_x(%{x: x}), do: x

  defp new_y(%{y: y, direction: :north}), do: y + 1
  defp new_y(%{y: y, direction: :south}), do: y - 1
  defp new_y(%{y: y}), do: y
end

defimpl String.Chars, for: MarsRover.Rover do
  @directions %{north: "N", east: "E", south: "S", west: "W"}
  def to_string(rover) do
    "#{rover.x}:#{rover.y}:#{@directions[rover.direction]}"
  end
end
