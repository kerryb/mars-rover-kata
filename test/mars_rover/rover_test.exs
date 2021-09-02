defmodule MarsRover.RoverTest do
  use ExUnit.Case
  alias MarsRover.{Grid, Rover}

  describe "to_string for MarsRover.Rover" do
    test "returns <x>:<y>:<heading>" do
      assert to_string(%{Rover.new() | x: 1, y: 2, direction: :north}) == "1:2:N"
    end
  end

  describe "MarsRover.Rover.new/0" do
    test "returns a rover at (0, 0), facing north on a 10x10 grid" do
      assert %Rover{x: 0, y: 0, direction: :north, grid: %Grid{width: 10, height: 10}} =
               Rover.new()
    end
  end

  describe "MarsRover.Rover.command/2" do
    for %{command: command, from: current_direction, to: new_direction} <- [
          %{command: "R", from: :north, to: :east},
          %{command: "R", from: :east, to: :south},
          %{command: "R", from: :south, to: :west},
          %{command: "R", from: :west, to: :north},
          %{command: "L", from: :north, to: :west},
          %{command: "L", from: :east, to: :north},
          %{command: "L", from: :south, to: :east},
          %{command: "L", from: :west, to: :south}
        ] do
      @command command
      @current_direction current_direction
      @new_direction new_direction
      test "turns to face #{@new_direction} if facing #{@current_direction} and given the command #{inspect(@command)}" do
        rover = %{Rover.new() | direction: @current_direction}
        assert %Rover{x: 0, y: 0, direction: @new_direction} = Rover.command(rover, @command)
      end
    end

    for %{direction: direction, from: {current_x, current_y}, to: {new_x, new_y}} <- [
          %{direction: :north, from: {2, 2}, to: {2, 3}},
          %{direction: :east, from: {2, 2}, to: {3, 2}},
          %{direction: :south, from: {2, 2}, to: {2, 1}},
          %{direction: :west, from: {2, 2}, to: {1, 2}}
        ] do
      @direction direction
      @current_x current_x
      @current_y current_y
      @new_x new_x
      @new_y new_y
      test "moves one square #{@direction} if facing #{@direction} and given the command \"M\"" do
        rover = %{Rover.new() | x: @current_x, y: @current_y, direction: @direction}
        assert %Rover{x: @new_x, y: @new_y, direction: @direction} = Rover.command(rover, "M")
      end
    end

    test "wraps round when it reaches the north edge" do
      rover = %Rover{x: 2, y: 9, direction: :north, grid: %Grid{width: 5, height: 10}}
      assert %Rover{x: 2, y: 0, direction: :north} = Rover.command(rover, "M")
    end

    test "wraps round when it reaches the east edge" do
      rover = %Rover{x: 4, y: 2, direction: :east, grid: %Grid{width: 5, height: 10}}
      assert %Rover{x: 0, y: 2, direction: :east} = Rover.command(rover, "M")
    end

    test "wraps round when it reaches the south edge" do
      rover = %Rover{x: 2, y: 0, direction: :south, grid: %Grid{width: 5, height: 10}}
      assert %Rover{x: 2, y: 9, direction: :south} = Rover.command(rover, "M")
    end

    test "wraps round when it reaches the west edge" do
      rover = %Rover{x: 0, y: 2, direction: :west, grid: %Grid{width: 5, height: 10}}
      assert %Rover{x: 4, y: 2, direction: :west} = Rover.command(rover, "M")
    end
  end
end
