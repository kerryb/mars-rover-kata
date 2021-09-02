defmodule MarsRover do
  alias MarsRover.Rover

  def execute(command_string) do
    command_string
    |> split()
    |> execute_in_turn(Rover.new())
    |> to_string()
  end

  defp split(command_string), do: String.codepoints(command_string)

  defp execute_in_turn(commands, rover) do
    Enum.reduce(commands, rover, fn command, rover -> Rover.command(rover, command) end)
  end
end
