defmodule CodiceFiscaleTest do
  use ExUnit.Case
  alias CodiceFiscale

  describe "calcola/5" do
    test "successfully calculates codice fiscale for valid inputs" do
      assert {:ok, "RSSMRA80A01H501U"} =
               CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "M", "H501")
    end

    test "successfully calculates codice fiscale for Pinco Pallo" do
      assert {:ok, "PLLPNC96E14L117A"} =
               CodiceFiscale.calcola("Pinco", "Pallo", "1996-05-14", "M", "L117")
    end

    test "successfully calculates codice fiscale for Test Prova" do
      assert {:ok, "PRVTST01A20F205F"} =
               CodiceFiscale.calcola("Test", "Prova", "2001-01-20", "M", "F205")
    end

    test "returns error for invalid name" do
      assert {:error, "Nome non valido"} =
               CodiceFiscale.calcola("123", "Rossi", "1980-01-01", "M", "H501")
    end

    test "returns error for null name" do
      assert {:error, "Nome non valido"} =
               CodiceFiscale.calcola("", "Rossi", "1980-01-01", "M", "H501")
    end

    test "returns error for invalid surname" do
      assert {:error, "Cognome non valido"} =
               CodiceFiscale.calcola("Mario", "123", "1980-01-01", "M", "H501")
    end

    test "returns error for null surname" do
      assert {:error, "Cognome non valido"} =
               CodiceFiscale.calcola("Mario", "", "1980-01-01", "M", "H501")
    end

    test "returns error for invalid date of birth" do
      assert {:error, "Data di nascita non valida"} =
               CodiceFiscale.calcola("Mario", "Rossi", "1980-13-01", "M", "H501")
    end

    test "returns error for wrong date of birth format" do
      assert {:error, "Data di nascita non valida"} =
               CodiceFiscale.calcola("Mario", "Rossi", "01-12-1980", "M", "H501")
    end

    test "returns error for invalid gender" do
      assert {:error, "Sesso non valido"} =
               CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "X", "H501")
    end

    test "returns error for invalid ISTAT code" do
      assert {:error, "Codice non valido"} =
               CodiceFiscale.calcola("Mario", "Rossi", "1980-01-01", "M", "INVALID")
    end
  end
end
