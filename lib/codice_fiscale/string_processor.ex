defmodule CodiceFiscale.StringProcessor do
  @moduledoc """
  Processes the string for calculating codice fiscale.
  """
  def process(str) do
    str
    |> String.replace(" ", "")
    |> String.upcase()
    |> String.replace(~r/[^A-Z]/, "")
  end
end
