defmodule FormatParagraph do
  def format do
    "problem2.txt"
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(&parse_paragraph/1)
    |> Enum.reduce("", fn
      paragraph, "" -> paragraph
      paragraph, acc -> acc <> "\n\n" <> paragraph
    end)
  end

  def parse_paragraph(text) do
    text
    |> String.split()
    |> Enum.chunk_while(
      "",
      fn word, current_line ->
        cond do
          current_line == "" ->
            {:cont, word}

          String.length(word) + 1 + String.length(current_line) <= 80 ->
            {:cont, current_line <> " " <> word}

          true ->
            {:cont, current_line, word}
        end
      end,
      fn current_line -> {:cont, current_line, ""} end
    )
    |> Enum.reduce("", fn
      line, "" -> line
      line, acc -> acc <> "\n" <> line
    end)
  end
end
