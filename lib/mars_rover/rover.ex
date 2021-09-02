defmodule MarsRover.Rover do
  @enforce_keys [:x, :y, :direction]
  defstruct [:x, :y, :direction]
end

defimpl String.Chars, for: MarsRover.Rover do
  @directions %{north: "N", east: "E", south: "S", west: "W"}
  def to_string(rover) do
    "#{rover.x}:#{rover.y}:#{@directions[rover.direction]}"
  end
end
