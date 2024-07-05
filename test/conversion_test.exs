defmodule CodiceFiscale.ConversionTest do
  use ExUnit.Case
  alias CodiceFiscale.Conversion
  alias CodiceFiscale.StringProcessor

  describe "nome/1" do
    test "returns correct codice for a name with more than 3 consonants" do
      assert "Francesco"
             |> StringProcessor.process()
             |> Conversion.nome() == "FNC"
    end

    test "returns correct codice for a name with exactly 3 consonants" do
      assert "Luca"
             |> StringProcessor.process()
             |> Conversion.nome() == "LCU"
    end

    test "returns correct codice for a name with 2 consonants and 2 vowels" do
      assert "Rita"
             |> StringProcessor.process()
             |> Conversion.nome() == "RTI"
    end

    test "returns correct codice for a name with 1 consonant and 2 vowels" do
      assert "Eva"
             |> StringProcessor.process()
             |> Conversion.nome() == "VEA"
    end

    test "returns correct codice for a name with no consonants" do
      assert "Iaia"
             |> StringProcessor.process()
             |> Conversion.nome() == "IAI"
    end
  end

  describe "cognome/1" do
    test "returns correct codice for a surname with more than 2 consonants" do
      assert "Bianchi"
             |> StringProcessor.process()
             |> Conversion.cognome() == "BNC"
    end

    test "returns correct codice for a surname with exactly 2 consonants" do
      assert "Li"
             |> StringProcessor.process()
             |> Conversion.cognome() == "LIX"
    end

    test "returns correct codice for a surname with 1 consonant and 2 vowels" do
      assert "Io"
             |> StringProcessor.process()
             |> Conversion.cognome() == "IOX"
    end

    test "returns correct codice for a surname with no consonants" do
      assert "Ai"
             |> StringProcessor.process()
             |> Conversion.cognome() == "AIX"
    end
  end

  describe "data_nascita/2" do
    test "returns correct codice for a male birthdate" do
      assert Conversion.data_nascita("1980-01-01", "M") == "80A01"
    end

    test "returns correct codice for a female birthdate" do
      assert Conversion.data_nascita("1980-01-01", "F") == "80A41"
    end

    test "returns correct codice for a male birthdate with single digit day" do
      assert Conversion.data_nascita("1980-01-09", "M") == "80A09"
    end

    test "returns correct codice for a female birthdate with single digit day" do
      assert Conversion.data_nascita("1980-01-09", "F") == "80A49"
    end

    test "returns correct codice for a date in a different month" do
      assert Conversion.data_nascita("1980-12-25", "M") == "80T25"
    end
  end
end
