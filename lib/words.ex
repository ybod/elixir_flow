defmodule Words do
  def filter_alphanumeric(word) do
    for <<c :: utf8 <- word>>, Unicode.alphanumeric?(c), into: "", do: <<c>>
  end

  def filter_regex(word) do
    String.replace(word, ~r/\W/u, "")
  end

  def pattern, do: :binary.compile_pattern(" ")
end
