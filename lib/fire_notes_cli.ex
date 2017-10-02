defmodule FireNotes.CLI do
  alias FireNotes

  def main(args) do
    {_, argv, _} = OptionParser.parse(args)
    parse_args(argv)
  end

  def parse_args(argv) do
    cmd = argv |> Enum.at(0)

    case cmd do
      "new" ->
        argv
        |> Enum.drop(1)
        |> Enum.join(" ")
        |> FireNotes.add

      "show" -> FireNotes.show
      _ -> IO.puts "invalid command"
    end
  end
end
