defmodule CodiceFiscale.Conversion do
  @moduledoc """
  Convert the parameters to the respective format useful for codice fiscale.
  """

  @vocals ["A", "E", "I", "O", "U"]
  @months %{
    "01" => "A",
    "02" => "B",
    "03" => "C",
    "04" => "D",
    "05" => "E",
    "06" => "H",
    "07" => "L",
    "08" => "M",
    "09" => "P",
    "10" => "R",
    "11" => "S",
    "12" => "T"
  }

  def nome(nome) do
    consonanti = String.graphemes(nome) |> Enum.filter(&consonante?/1)
    vocali = String.graphemes(nome) |> Enum.filter(&vocale?/1)

    risultato =
      case length(consonanti) do
        n when n > 3 -> [Enum.at(consonanti, 0), Enum.at(consonanti, 2), Enum.at(consonanti, 3)]
        3 -> [Enum.at(consonanti, 0), Enum.at(consonanti, 1), Enum.at(consonanti, 2)]
        2 -> [Enum.at(consonanti, 0), Enum.at(consonanti, 1), Enum.at(vocali ++ ["X"], 0)]
        1 -> [Enum.at(consonanti, 0) | Enum.take(vocali ++ ["X", "X"], 2)]
        _ -> Enum.take(vocali ++ ["X", "X", "X"], 3)
      end

    Enum.join(risultato)
  end

  def cognome(cognome) do
    consonanti = String.graphemes(cognome) |> Enum.filter(&consonante?/1)
    vocali = String.graphemes(cognome) |> Enum.filter(&vocale?/1)

    risultato =
      case length(consonanti) do
        n when n > 2 -> [Enum.at(consonanti, 0), Enum.at(consonanti, 1), Enum.at(consonanti, 2)]
        2 -> [Enum.at(consonanti, 0), Enum.at(consonanti, 1), Enum.at(vocali ++ ["X"], 0)]
        1 -> [Enum.at(consonanti, 0) | Enum.take(vocali ++ ["X", "X"], 2)]
        _ -> Enum.take(vocali ++ ["X", "X", "X"], 3)
      end

    Enum.join(risultato)
  end

  def data_nascita(data_nascita, sesso) do
    {yyyy, mm, dd} = parse_date(data_nascita)
    year = String.slice(Integer.to_string(yyyy), 2, 2)
    month = Map.get(@months, mm)
    day = if sesso == "F", do: Integer.to_string(dd + 40), else: Integer.to_string(dd)
    "#{year}#{month}#{String.pad_leading(day, 2, "0")}"
  end

  defp parse_date(date) do
    [yyyy, mm, dd] = String.split(date, "-")
    {String.to_integer(yyyy), mm, String.to_integer(dd)}
  end

  defp vocale?(char) do
    char in @vocals
  end

  defp consonante?(char) do
    char not in @vocals
  end
end
