defmodule CodiceFiscale.StringProcessor do
  def process(str) do
    str
    |> String.replace(" ", "")
    |> String.upcase()
    |> String.replace(~r/[^A-Z]/, "")
  end
end
