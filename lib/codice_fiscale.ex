defmodule CodiceFiscale do
  alias CodiceFiscale.{Conversion, CharCheck, Validation, StringProcessor}
  require Logger

  @doc """
  Calcola il codice fiscale dato un nome, cognome, data di nascita, sesso e codice ISTAT del luogo di nascita.

  ## Esempio

      iex> CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "M", "H501")
      {:ok, "RSSMRA80A01H501U"}

  """
  def calcola(nome, cognome, data_nascita, sesso, codice) do
    Logger.info("Calcolo del codice fiscale per #{nome} #{cognome}")

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
        Logger.error("Errore nel calcolo del codice fiscale: #{msg}")
        {:error, msg}
    end
  end

  def valida(
        codice_fiscale,
        %{nome: nome, cognome: cognome, data_nascita: data_nascita, sesso: sesso, codice: codice} =
          _dati_anagrafici
      ) do
    case calcola(nome, cognome, data_nascita, sesso, codice) do
      {:ok, codice_calcolato} ->
        if codice_calcolato == codice_fiscale do
          Logger.info("Il codice fiscale corrisponde ai dati anagrafici.")
          {:ok, "Il codice fiscale corrisponde ai dati anagrafici."}
        else
          Logger.warning("Il codice fiscale non corrisponde ai dati anagrafici.")
          {:error, "Il codice fiscale non corrisponde ai dati anagrafici."}
        end

      {:error, msg} ->
        Logger.error("Errore nel calcolo del codice fiscale: #{msg}")
        {:error, "Errore nel calcolo del codice fiscale: #{msg}"}
    end
  end
end
