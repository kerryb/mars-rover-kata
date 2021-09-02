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
end

defimpl String.Chars, for: MarsRover.Rover do
  @directions %{north: "N", east: "E", south: "S", west: "W"}
  def to_string(rover) do
    "#{rover.x}:#{rover.y}:#{@directions[rover.direction]}"
  end
end
