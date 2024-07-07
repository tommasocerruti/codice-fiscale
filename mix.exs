defmodule CodiceFiscale.MixProject do
  use Mix.Project

  def project do
    [
      app: :codice_fiscale,
      version: "0.1.0",
      elixir: "~> 1.16.1",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/project.plt"}
      ],
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "Library to calculate Italian fiscal code (codice fiscale).",
      package: package(),
      runtime: [config_path: "config/config.exs"],
      source_url: "https://github.com/tommasocerruti/codice_fiscale"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      ci: ["ci"]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
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
