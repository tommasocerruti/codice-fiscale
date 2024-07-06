# CodiceFiscale
[![Linguaggio](https://img.shields.io/badge/linguaggio-elixir-purple.svg)](https://elixir-lang.org/)
[![Licenza](https://img.shields.io/badge/licenza-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Contributi](https://img.shields.io/badge/contributi-benvenuti-brightgreen.svg)](CONTRIBUTING.md)

`CodiceFiscale` è una libreria [Elixir](https://elixir-lang.org/) che fornisce diverse funzioni relative al codice fiscale italiano.   
Essa permette di generare un codice fiscale basato su informazioni personali e di verificare se un codice fiscale fornito corrisponde ai dati personali forniti.

## Funzionalità

- **Calcolo del Codice Fiscale:** Dato un nome, cognome, data di nascita, sesso e codice Belfiore del luogo di nascita, calcola il corrispondente codice fiscale.
- **Verifica del Codice Fiscale:** Controlla se un codice fiscale fornito corrisponde al codice fiscale atteso basato sui dati personali forniti.

## Installazione

Aggiungi `CodiceFiscale` come dipendenza nel tuo file `mix.exs`:

```elixir
defp deps do
  [
    {:codice_fiscale, "~> 0.1.0"}
  ]
end
```

Quindi, scarica le dipendenze:

```shell
$ mix deps.get
```

## Usage
### Calculate Codice Fiscale
Calculates codice fiscale given name, surname, birthdate, sex and Belfiore code.    
```elixir
iex> CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "M", "H501")
{:ok, "RSSMRA80A01H501U"}
```

### Verifica del Codice Fiscale
Verifica se il codice fiscale corrisponde ai dati anagrafici forniti.   
```elixir
iex> CodiceFiscale.verifica("RSSMRA80A01H501U", %{nome: "Mario", cognome: "Rossi", data_nascita: "1980-01-01", sesso: "M", codice: "H501"})
{:ok, "Il codice fiscale corrisponde ai dati anagrafici."}
```

## Configurazione
Per abilitare il logging, imposta la chiave :logging_enabled a true nell'ambiente della tua applicazione:  

```elixir
config :codice_fiscale, logging_enabled: true
```

## Contributi
I contributi sono benvenuti! Non esitare a inviare issue e pull request.   

## Licenza
Questa libreria è rilasciata sotto la Licenza MIT.    