# CodiceFiscale
[![Language](https://img.shields.io/badge/language-elixir-purple.svg)](https://elixir-lang.org/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](CONTRIBUTING.md)

`CodiceFiscale` is an [Elixir](https://elixir-lang.org/) library providing different functions regarding the Italian fiscal code (codice fiscale).   
It provides functions to generate a codice fiscale based on personal information and validate whether a given codice fiscale corresponds to provided personal data.

## Features

- **Calculate Codice Fiscale:** Given a name, surname, birthdate, sex, and Belfiore code of the birthplace, it computes the corresponding codice fiscale.
- **Verify Codice Fiscale:** Checks if a provided codice fiscale matches the expected codice fiscale based on given personal data.

## Installation

Add `CodiceFiscale` as a dependency in your `mix.exs` file:

```elixir
defp deps do
  [
    {:codice_fiscale, "~> 0.1.0"}
  ]
end
```

Then, fetch dependencies:

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

### Verify Codice Fiscale
Verifies codice fiscale comparing it to provided personal data.   
```elixir
iex> CodiceFiscale.verifica("RSSMRA80A01H501U", %{nome: "Mario", cognome: "Rossi", data_nascita: "1980-01-01", sesso: "M", codice: "H501"})
{:ok, "Il codice fiscale corrisponde ai dati anagrafici."}
```

## Configuration
To enable logging, set the :logging_enabled key to true in your application environment:

```elixir
config :codice_fiscale, logging_enabled: true
```

## Contributing
Contributions are welcome! Please feel free to submit issues and pull requests.

## License
This library is released under the MIT License.