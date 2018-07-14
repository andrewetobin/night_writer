require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_read'

class NightReadTest < Minitest::Test

  def test_it_exists
    nr = NightRead.new

    assert_instance_of NightRead, nr
  end

  def test_it_can_split_lines
    nr = NightRead.new
    expected = ["...00.00", "..00.0..", ".00.0.0."]
    braille = "...00.00\n..00.0..\n.00.0.0."

    assert_equal expected, nr.parse_braille_lines(braille)
  end

  def test_it_can_split_braille_into_chunks
    nr = NightRead.new
    expected_1 = [["..", ".0", "0.", "00"], ["..", "00", ".0", ".."], [".0", "0.", "0.", "0."]]
    three_strings = ["...00.00", "..00.0..", ".00.0.0."]

    assert_equal expected_1, nr.format_braille_keys(three_strings)
  end

  def test_format_braille_keys
    nr = NightRead.new
    expected = [["..", "..", ".0"], [".0", "00", "0."], ["0.", ".0", "0."], ["00", "..", "0."]]
    chunks = [["..", ".0", "0.", "00"], ["..", "00", ".0", ".."], [".0", "0.", "0.", "0."]]

    nr.braille_keys(chunks)
    assert_equal expected, nr.braille_keys(chunks)
  end

  def test_translate_to_english
    nr = NightRead.new

    letters_in_braille = [["..", "..", ".0"], [".0", "00", "0."], [".0", "0.", ".."], ["00", "00", ".."], ["0.", ".0", ".."], ["0.", "00", "0."], ["..", "..", ".."], ["..", "..", ".0"], [".0", "00", ".0"], ["0.", ".0", "0."], ["0.", ".0", "0."], ["00", ".0", ".."], [".0", "0.", "0."]]
    expected = ["caps", "t", "i", "g", "e", "r", " ", "caps", "w", "o", "o", "d", "s"]

    assert_equal expected, nr.translate_to_english(letters_in_braille)
  end

  def test_capitalize
    nr = NightRead.new

    letters_in_english = ["caps", "t", "i", "g", "e", "r", " ", "caps", "w", "o", "o", "d", "s"]
    assert_equal "Tiger Woods", nr.capitalize(letters_in_english)
  end

  def test_integration
    nr = NightRead.new
    braille = "..000.0.0.0.0.000.\n.....00..000...0.0\n.0..0.0.0.0.....0."

    assert_equal "Colorado", nr.encode_to_english(braille)
  end
end
