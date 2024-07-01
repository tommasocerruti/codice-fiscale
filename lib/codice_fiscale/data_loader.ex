defmodule CodiceFiscale.DataLoader do
  alias NimbleCSV

  @csv_path "priv/data/comuni.csv"

  def load_comuni do
    :ets.new(:comuni, [:named_table, :public, read_concurrency: true])

    @csv_path
    |> File.read!()
    |> NimbleCSV.parse_string(headers: true)
    |> Enum.each(fn [comune, codice] ->
      :ets.insert(:comuni, {comune, codice})
    end)
  end

  def get_comune_codice(comune) do
    case :ets.lookup(:comuni, comune) do
      [{_, codice}] -> codice
      [] -> "NOT FOUND"
    end
  end
end
