defmodule CodiceFiscale.Conversion do
  @vocals ["A", "E", "I", "O", "U"]
  @months %{"01" => "A", "02" => "B", "03" => "C", "04" => "D", "05" => "E", "06" => "H", "07" => "L", "08" => "M", "09" => "P", "10" => "R", "11" => "S", "12" => "T"}
  @comuni CodiceFiscale.DataLoader.load_comuni()

  def cognome(cognome) do
    cognome
    |> String.replace(~r/[^A-Z]/, "")
    |> take_chars()
    |> String.pad_trailing(3, "X")
  end

  def nome(nome) do
    nome
    |> String.replace(~r/[^A-Z]/, "")
    |> take_chars_for_name()
    |> String.pad_trailing(3, "X")
  end

  defp take_chars(string) do
    consonanti = String.graphemes(string) |> Enum.filter(&(&1 not in @vocals))
    vocals = String.graphemes(string) |> Enum.filter(&(&1 in @vocals))
    take_chars(consonanti, vocals)
  end

  defp take_chars(consonanti, vocals) when length(consonanti) >= 3 do
    Enum.join(Enum.take(consonanti, 3))
  end

  defp take_chars(consonanti, vocals) do
    Enum.join(consonanti ++ Enum.take(vocals, 3 - length(consonanti)))
  end

  defp take_chars_for_name(string) do
    consonanti = String.graphemes(string) |> Enum.filter(&(&1 not in @vocals))

    case length(consonanti) do
      n when n > 3 ->
        consonanti
        |> Enum.drop(1)
        |> Enum.take(3)
        |> Enum.join()
      _ ->
        take_chars(consonanti, String.graphemes(string) |> Enum.filter(&(&1 in @vocals)))
    end
  end

  def data_nascita(data_nascita, sesso) do
    {yyyy, mm, dd} = parse_date(data_nascita)
    year = String.slice(Integer.to_string(yyyy), 2, 2)
    month = Map.get(@months, mm)
    day = if sesso == "F", do: Integer.to_string(dd + 40), else: Integer.to_string(dd)
    "#{year}#{month}#{String.pad_leading(day, 2, "0")}"
  end

  def comune(comune) do
    CodiceFiscale.DataLoader.get_comune_codice(comune)
  end

  defp parse_date(date) do
    [yyyy, mm, dd] = String.split(date, "-")
    {String.to_integer(yyyy), mm, String.to_integer(dd)}
  end
end
