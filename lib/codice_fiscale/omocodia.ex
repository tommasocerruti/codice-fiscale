defmodule CodiceFiscale.Omocodia do
  @letters "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  @omocodia_table %{
    0 => "L",
    1 => "M",
    2 => "N",
    3 => "P",
    4 => "Q",
    5 => "R",
    6 => "S",
    7 => "T",
    8 => "U",
    9 => "V"
  }

  @weights_even %{
    "0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9,
    "A" => 0, "B" => 1, "C" => 2, "D" => 3, "E" => 4, "F" => 5, "G" => 6, "H" => 7, "I" => 8, "J" => 9,
    "K" => 10, "L" => 11, "M" => 12, "N" => 13, "O" => 14, "P" => 15, "Q" => 16, "R" => 17, "S" => 18, "T" => 19,
    "U" => 20, "V" => 21, "W" => 22, "X" => 23, "Y" => 24, "Z" => 25
  }

  @weights_odd %{
    "0" => 1, "1" => 0, "2" => 5, "3" => 7, "4" => 9, "5" => 13, "6" => 15, "7" => 17, "8" => 19, "9" => 21,
    "A" => 1, "B" => 0, "C" => 5, "D" => 7, "E" => 9, "F" => 13, "G" => 15, "H" => 17, "I" => 19, "J" => 21,
    "K" => 1, "L" => 0, "M" => 5, "N" => 7, "O" => 9, "P" => 13, "Q" => 15, "R" => 17, "S" => 19, "T" => 21,
    "U" => 1, "V" => 0, "W" => 5, "X" => 7, "Y" => 9, "Z" => 13
  }

  @doc """
  Calcola il carattere di controllo per il codice fiscale.

  ## Esempio

      iex> CodiceFiscale.Omocodia.calcola_carattere_controllo("RSSMRA80A01H501")
      "X"
  """
  def calcola_carattere_controllo(codice) do
    codice
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {char, index}, acc ->
      weight = if rem(index, 2) == 0, do: Map.get(@weights_odd, char), else: Map.get(@weights_even, char)
      acc + weight
    end)
    |> rem(26)
    |> (fn x -> String.at(@letters, x) end).()
  end
end
