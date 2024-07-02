defmodule CodiceFiscale.MixProject do
  use Mix.Project

  def project do
    [
      app: :codice_fiscale,
      version: "0.1.0",
      elixir: "~> 1.16.1",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "Framework per il calcolo del codice fiscale italiano.",
      package: package(),
      source_url: "https://github.com/tommasocerruti/codice_fiscale"
    ]
  end

  def application do
    [
      extra_applications: [:logger, :ets]
    ]
  end

  defp deps do
    [
      {:nimble_csv, "~> 1.2.0"},
      {:levenshtein, "~> 0.3.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README.md", "LICENSE"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tommasocerruti/codice_fiscale"}
    ]
  end
end
