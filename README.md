# CodiceFiscale

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `codice_fiscale` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:codice_fiscale, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/codice_fiscale>.

# codice-fiscale

# CodiceFiscale

![License](https://img.shields.io/badge/license-MIT-blue.svg)

`CodiceFiscale` is an Elixir library for calculating and verifying the Italian fiscal code (codice fiscale). It provides functions to generate a codice fiscale based on personal information and validate whether a given codice fiscale corresponds to provided personal data.

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
```elixir
iex> CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "M", "H501")
{:ok, "RSSMRA80A01H501U"}
```

### Verify Codice Fiscale
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