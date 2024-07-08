defmodule CodiceFiscale.Validation do
  @moduledoc """
  ITA: Valida i parametri utili per il codice fiscale.

  ENG: Validates the parameters useful for codice fiscale.
  """

  @doc """
  ITA: Valida che il nome sia una stringa non vuota.

  ENG: Validates that the name is a non-empty string.

  ## Example

      iex> CodiceFiscale.Validation.validate_nome("Mario")
      :ok

      iex> CodiceFiscale.Validation.validate_nome("")
      {:error, "Nome non valido"}
  """
  def validate_nome(nome) when is_binary(nome) and byte_size(nome) > 0, do: :ok
  def validate_nome(_), do: {:error, "Nome non valido"}

  @doc """
  ITA: Valida che il cognome sia una stringa non vuota.

  ENG: Validates that the surname is a non-empty string.

  ## Example

      iex> CodiceFiscale.Validation.validate_cognome("Rossi")
      :ok

      iex> CodiceFiscale.Validation.validate_cognome("")
      {:error, "Cognome non valido"}
  """
  def validate_cognome(cognome) when is_binary(cognome) and byte_size(cognome) > 0, do: :ok
  def validate_cognome(_), do: {:error, "Cognome non valido"}

  @doc """
  ITA: Valida che la data di nascita sia nel formato ISO 8601 (YYYY-MM-DD).

  ENG: Validates that the birth date is in ISO 8601 format (YYYY-MM-DD).

  ## Example

      iex> CodiceFiscale.Validation.validate_data_nascita("1980-01-01")
      :ok

      iex> CodiceFiscale.Validation.validate_data_nascita("01-01-1980")
      {:error, "Data di nascita non valida"}
  """
  def validate_data_nascita(data_nascita) do
    case Date.from_iso8601(data_nascita) do
      {:ok, _} -> :ok
      {:error, _} -> {:error, "Data di nascita non valida"}
    end
  end

  @doc """
  ITA: Valida che il sesso sia 'M' o 'F'.

  ENG: Validates that the sex is 'M' or 'F'.

  ## Example

      iex> CodiceFiscale.Validation.validate_sesso("M")
      :ok

      iex> CodiceFiscale.Validation.validate_sesso("X")
      {:error, "Sesso non valido"}
  """
  def validate_sesso("M"), do: :ok
  def validate_sesso("F"), do: :ok
  def validate_sesso(_), do: {:error, "Sesso non valido"}

  @doc """
  ITA: Valida che il codice catastale sia una lettera seguita da tre cifre.

  ENG: Validates that the catastale code is a letter followed by three digits.

  ## Example

      iex> CodiceFiscale.Validation.validate_codice("H501")
      :ok

      iex> CodiceFiscale.Validation.validate_codice("501H")
      {:error, "Codice non valido"}
  """
  def validate_codice(codice) do
    case Regex.match?(~r/^[A-Z]\d{3}$/, codice) do
      true -> :ok
      false -> {:error, "Codice non valido"}
    end
  end
end
