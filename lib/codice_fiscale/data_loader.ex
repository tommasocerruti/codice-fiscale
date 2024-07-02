defmodule CodiceFiscale.DataLoader do
  alias NimbleCSV.RFC4180, as: CSV
  alias Levenshtein, as: LVN

  @csv_path "priv/data/comuni.csv"

  def load_comuni do
    :ets.new(:comuni, [:named_table, :public, read_concurrency: true])

    @csv_path
    |> File.read!()
    |> CSV.parse_string(headers: true)
    |> Enum.each(fn [comune, codice] ->
      :ets.insert(:comuni, {comune, codice})
    end)
  end

  def get_comune_codice(comune) do
    case :ets.lookup(:comuni, comune) do
      [{_, codice}] -> codice
      [] -> find_closest_comune(comune)
    end
  end

  defp find_closest_comune(comune) do
    :ets.tab2list(:comuni)
    |> Enum.map(fn {c, codice} -> {c, codice, LVN.distance(c, comune)} end)
    |> Enum.group_by(fn {_c, _codice, distance} -> distance end)
    |> Enum.min_by(fn {distance, _list} -> distance end)
    |> case do
      {_, closest_comuni} ->
        closest_comuni
        |> Enum.min_by(fn {c, _codice, _distance} -> String.length(c) end)
        |> case do
          {_closest_comune, codice, _distance} -> {:ok, codice}
          _ -> {:error, "NOT FOUND"}
        end
    end
  end

end
