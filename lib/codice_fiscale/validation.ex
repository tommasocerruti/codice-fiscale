defmodule CodiceFiscale.Validation do
  def validate_nome(nome) when is_binary(nome) and byte_size(nome) > 0, do: :ok
  def validate_nome(_), do: {:error, "Nome non valido"}

  def validate_cognome(cognome) when is_binary(cognome) and byte_size(cognome) > 0, do: :ok
  def validate_cognome(_), do: {:error, "Cognome non valido"}

  def validate_data_nascita(data_nascita) do
    case Date.from_iso8601(data_nascita) do
      {:ok, _} -> :ok
      {:error, _} -> {:error, "Data di nascita non valida"}
    end
  end

  def validate_sesso("M"), do: :ok
  def validate_sesso("F"), do: :ok
  def validate_sesso(_), do: {:error, "Sesso non valido"}

  def validate_comune(comune) do
    if CodiceFiscale.DataLoader.get_comune_codice(comune) == "XXXX" do
      {:error, "Comune non valido"}
    else
      :ok
    end
  end
end
