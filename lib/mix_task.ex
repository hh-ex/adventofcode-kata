defmodule Mix.Tasks.Day do
  use Mix.Task

  @days %{
    1 => %{
      1 => {:stream_lines, AocKata.Day1, :resulting_frequency},
      2 => {:stream_lines, AocKata.Day1, :resulting_frequency_fixed}
    },
    2 => %{
      1 => {:stream_lines, AocKata.Day2, :checksum},
      2 => {:stream_lines, AocKata.Day2, :common_letters},
    }
  }

  def run(args) do
    case args do
      [] ->
        for {day, parts} <- @days, {part, _} <- parts, do: run(day, part)
      [day] ->
        day = String.to_integer(day)
        run(day, 1)
        run(day, 2)
      [day, "part", part] ->
        day = String.to_integer(day)
        part = String.to_integer(part)
        run(day, part)
    end
  end

  def run(day, part) do
    filename = filename(day)
    if not File.exists?(filename) do
      print_missing_input(day)
    else
      part_def = Map.get(Map.get(@days, day, %{}), part, nil)
      case part_def do
        nil ->
          print_missing_part(day, part)
        {input_fun, mod, output_fun} ->
          input = apply(__MODULE__, input_fun, [filename])
          output = apply(mod, output_fun, [input])
          print_result(day, part, output)
      end
    end
  end

  def stream_lines(filename) do
    filename
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end

  def filename(day) do
    "./priv/inputs"
    |> Path.join("day#{day}.txt")
  end

  def print_missing_input(day) do
    IO.puts [
      IO.ANSI.red,
      "No input file for day ",
      IO.ANSI.blue,
      inspect(day),
      IO.ANSI.red,
      ". Paste your input from adventofcode.com into ",
      IO.ANSI.green,
      filename(day),
      IO.ANSI.reset
    ]
  end

  def print_missing_part(day, part) do
    IO.puts [
      IO.ANSI.red,
      "No definition found for day ",
      IO.ANSI.blue,
      inspect(day),
      IO.ANSI.red,
      ", part ",
      IO.ANSI.blue,
      inspect(part),
      IO.ANSI.red,
      ".",
      IO.ANSI.reset
    ]
  end

  def print_result(day, part, result) do
    part = case part do
      1 -> "one"
      2 -> "two"
    end
    IO.puts [
      "The result for ",
      IO.ANSI.blue,
      "day #{day}",
      IO.ANSI.reset,
      ",",
      IO.ANSI.blue,
      " part #{part}",
      IO.ANSI.reset,
      " is ",
      IO.ANSI.green,
      inspect(result),
      IO.ANSI.reset,
      "."
    ]
  end
end
