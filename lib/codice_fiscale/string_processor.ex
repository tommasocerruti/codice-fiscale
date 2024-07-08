defmodule CodiceFiscale.StringProcessor do
  @moduledoc """
  ITA: Processa una stringa per il calcolo del codice fiscale.

  ENG: Processes the string for calculating codice fiscale.
  """
  @doc """
  ITA: Rimuove spazi, converte in maiuscolo e rimuove caratteri non alfabetici dalla stringa.

  ENG: Removes spaces, converts to uppercase, and removes non-alphabetic characters from the string.

  ## Example

      iex> CodiceFiscale.StringProcessor.process("Mario Rossi123")
      "MARIOROSSI"
  """
  def process(str) do
    str
    |> String.replace(" ", "")
    |> String.upcase()
    |> String.replace(~r/[^A-Z]/, "")
  end
end
