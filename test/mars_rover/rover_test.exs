defmodule MarsRover.RoverTest do
  use ExUnit.Case
  alias MarsRover.Rover

  describe "to_string for MarsRover.Rover" do
    test "returns <x>:<y>:<heading>" do
      assert to_string(%Rover{x: 1, y: 2, direction: :north}) == "1:2:N"
    end
  end

  describe "MarsRover.Rover.new/0" do
    test "returns a rover at (0, 0), facing north" do
      assert %Rover{x: 0, y: 0, direction: :north} = Rover.new()
    end
  end
end
