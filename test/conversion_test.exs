defmodule CodiceFiscale.ConversionTest do
  use ExUnit.Case
  alias CodiceFiscale.Conversion

  describe "nome/1" do
    test "returns correct codice for a name with more than 3 consonants" do
      assert Conversion.nome("Francesco") == "FRC"
    end

    test "returns correct codice for a name with exactly 3 consonants" do
      assert Conversion.nome("Luca") == "LCA"
    end

    test "returns correct codice for a name with 2 consonants and 2 vowels" do
      assert Conversion.nome("Rita") == "RTA"
    end

    test "returns correct codice for a name with 1 consonant and 2 vowels" do
      assert Conversion.nome("Eva") == "EVX"
    end

    test "returns correct codice for a name with no consonants" do
      assert Conversion.nome("Iaia") == "AIX"
    end
  end

  describe "cognome/1" do
    test "returns correct codice for a surname with more than 2 consonants" do
      assert Conversion.cognome("Bianchi") == "BNC"
    end

    test "returns correct codice for a surname with exactly 2 consonants" do
      assert Conversion.cognome("Li") == "LIX"
    end

    test "returns correct codice for a surname with 1 consonant and 2 vowels" do
      assert Conversion.cognome("Io") == "IOX"
    end

    test "returns correct codice for a surname with no consonants" do
      assert Conversion.cognome("Ai") == "AIX"
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
