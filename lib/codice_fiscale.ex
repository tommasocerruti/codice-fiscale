defmodule CodiceFiscale do
  alias CodiceFiscale.{Conversion, CharCheck, Validation, StringProcessor}
  require Logger

  @moduledoc """
  Module containing the main functions regarding codice fiscale.
  """

  @doc """
  ITA: Calcola il codice fiscale dato un nome, cognome, data di nascita, sesso e codice catastale del luogo di nascita.

  ENG: Calculates the codice fiscale given a name, surname, birthdate, sex and catastale code of the birthplace.

  ## Example

      iex> CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "M", "H501")
      {:ok, "RSSMRA80A01H501U"}

  """
  def calcola(nome, cognome, data_nascita, sesso, codice) do
    log_info("Calcolo del codice fiscale per #{nome} #{cognome}")

    cognome_processed = StringProcessor.process(cognome)
    nome_processed = StringProcessor.process(nome)

    with :ok <- Validation.validate_nome(nome_processed),
         :ok <- Validation.validate_cognome(cognome_processed),
         :ok <- Validation.validate_data_nascita(data_nascita),
         :ok <- Validation.validate_sesso(sesso),
         :ok <- Validation.validate_codice(codice) do
      codice_cognome = Conversion.cognome(cognome_processed)
      codice_nome = Conversion.nome(nome_processed)
      codice_data = Conversion.data_nascita(data_nascita, sesso)
      parziale = "#{codice_cognome}#{codice_nome}#{codice_data}#{codice}"
      carattere_controllo = CharCheck.calcola_carattere_controllo(parziale)

      {:ok, "#{parziale}#{carattere_controllo}"}
    else
      {:error, msg} ->
        log_error("Errore nel calcolo del codice fiscale: #{msg}")
        {:error, msg}
    end
  end

  @doc """
  ITA: Verifica se un codice fiscale calcolato corrisponde ai dati anagrafici forniti.

  ENG: Verifies if a codice fiscale calculated corresponds to the provided anagraphic data.

  ## Esempio

      iex> CodiceFiscale.verifica("RSSMRA80A01H501U", %{nome: "Mario", cognome: "Rossi", data_nascita: "1980-01-01", sesso: "M", codice: "H501"})
      {:ok, "Il codice fiscale corrisponde ai dati anagrafici."}

  """
  def verifica(
        codice_fiscale,
        %{nome: nome, cognome: cognome, data_nascita: data_nascita, sesso: sesso, codice: codice} =
          _dati_anagrafici
      ) do
    log_info("Verifica che #{codice_fiscale} sia il codice fiscale di #{nome} #{cognome}")

    case calcola(nome, cognome, data_nascita, sesso, codice) do
      {:ok, codice_calcolato} ->
        if codice_calcolato == codice_fiscale do
          log_info("Il codice fiscale corrisponde ai dati anagrafici.")
          {:ok, "Il codice fiscale corrisponde ai dati anagrafici."}
        else
          log_warning("Il codice fiscale non corrisponde ai dati anagrafici.")
          {:error, "Il codice fiscale non corrisponde ai dati anagrafici."}
        end

      {:error, msg} ->
        {:error, "Errore nel calcolo del codice fiscale: #{msg}"}
    end
  end

  defp log_info(message) do
    if Application.get_env(:codice_fiscale, :logging_enabled, true) do
      Logger.info(message)
    end
  end

  defp log_warning(message) do
    if Application.get_env(:codice_fiscale, :logging_enabled, true) do
      Logger.warning(message)
    end
  end

  defp log_error(message) do
    if Application.get_env(:codice_fiscale, :logging_enabled, true) do
      Logger.error(message)
    end
  end
end
