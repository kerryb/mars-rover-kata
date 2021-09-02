defmodule MarsRoverTest do
  use ExUnit.Case

  describe "MarsRover.execute/1" do
    test "returns the correct final position for a simple path" do
      assert MarsRover.execute("MMRMMLM") == "2:3:N"
    end

    test "returns the correct final position for a path that wraps round the edge of the grid" do
      assert MarsRover.execute("MMMMMMMMMM") == "0:0:N"
    end
  end
end
