defmodule CodiceFiscale.Conversion do
  @moduledoc """
  ITA: Converte i parametri nei rispettivi formati utili per il codice fiscale.

  ENG: Convert the parameters to the respective format useful for codice fiscale.
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

  @doc """
  ITA: Converte il nome nel formato richiesto per il codice fiscale.

  ENG: Converts the given name into the format required for codice fiscale.

  ## Example

      iex> CodiceFiscale.Conversion.nome("Mario")
      "MRA"
  """
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

  @doc """
  ITA: Converte il cognome nel formato richiesto per il codice fiscale.

  ENG: Converts the given surname into the format required for codice fiscale.

  ## Example

      iex> CodiceFiscale.Conversion.cognome("Rossi")
      "RSS"
  """
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

  @doc """
  ITA: Converte la data di nascita e il sesso nel formato richiesto per il codice fiscale.

  ENG: Converts the given birthdate and gender into the format required for codice fiscale.

  ## Example

      iex> CodiceFiscale.Conversion.data_nascita("1980-05-15", "M")
      "80E15"

      iex> CodiceFiscale.Conversion.data_nascita("1980-05-15", "F")
      "80E55"
  """
  def data_nascita(data_nascita, sesso) do
    {yyyy, mm, dd} = parse_date(data_nascita)
    year = String.slice(Integer.to_string(yyyy), 2, 2)
    month = Map.get(@months, mm)
    day = if sesso == "F", do: Integer.to_string(dd + 40), else: Integer.to_string(dd)
    "#{year}#{month}#{String.pad_leading(day, 2, "0")}"
  end

  @doc false
  defp parse_date(date) do
    [yyyy, mm, dd] = String.split(date, "-")
    {String.to_integer(yyyy), mm, String.to_integer(dd)}
  end

  @doc false
  defp vocale?(char) do
    char in @vocals
  end

  @doc false
  defp consonante?(char) do
    char not in @vocals
  end
end
