defmodule CodiceFiscale do
  alias CodiceFiscale.{Conversion, Omocodia, Validation, DataLoader}
  require Logger

  @doc """
  Inizializza il caricamento dei dati dei comuni.
  """
  def init do
    DataLoader.load_comuni()
  end

  @doc """
  Calcola il codice fiscale dato un nome, cognome, data di nascita, sesso e comune.

  ## Esempio

      iex> CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "M", "Roma")
      {:ok, "RSSMRA80A01H501X"}

  """
  def calcola(nome, cognome, data_nascita, sesso, comune) do
    Logger.info("Calcolo del codice fiscale per #{nome} #{cognome}")

    with :ok <- Validation.validate_nome(nome),
         :ok <- Validation.validate_cognome(cognome),
         :ok <- Validation.validate_data_nascita(data_nascita),
         :ok <- Validation.validate_sesso(sesso),
         :ok <- Validation.validate_comune(comune) do
      codice_cognome = Conversion.cognome(cognome)
      codice_nome = Conversion.nome(nome)
      codice_data = Conversion.data_nascita(data_nascita, sesso)
      codice_comune = Conversion.comune(comune)

      parziale = "#{codice_cognome}#{codice_nome}#{codice_data}#{codice_comune}"
      carattere_controllo = Omocodia.calcola_carattere_controllo(parziale)

      {:ok, "#{parziale}#{carattere_controllo}"}
    else
      {:error, msg} ->
        Logger.error("Errore nel calcolo del codice fiscale: #{msg}")
        {:error, msg}
    end
  end
end
