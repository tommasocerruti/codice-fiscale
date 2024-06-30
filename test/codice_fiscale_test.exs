defmodule CodiceFiscaleTest do
  use ExUnit.Case
  alias CodiceFiscale

  test "calcola codice fiscale" do
    assert CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "M", "H501") == "RSSMRA80A01H501X"
  end
end
