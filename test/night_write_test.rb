require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'

class NightWriteTest < Minitest::Test

  def test_it_exists
    night_writer = NightWrite.new

    assert_instance_of NightWrite, night_writer
  end

  def test_parse_text
    night_writer = NightWrite.new

    expected = ["caps", "h", "e", "l", "l", "o", " ", "caps", "w", "o", "r", "l", "d"]
    assert_equal expected, night_writer.parse_text("Hello World")
  end

  def test_it_can_encode_one_letter
    night_writer = NightWrite.new
    night_writer2 = NightWrite.new

    assert_equal "0.\n..\n..", night_writer.encode_to_braille("a")
    assert_equal "0.\n00\n..", night_writer2.encode_to_braille("h")
  end

  def test_it_can_encode_upcase_letters
    night_writer = NightWrite.new
    # night_writer_2 = NightWrite.new
    assert_equal "..0.\n....\n.0..", night_writer.encode_to_braille("A")
    assert_equal "..0.\n..00\n.0..", night_writer.encode_to_braille("H")
  end

  def test_format_translation
    night_writer = NightWrite.new

    expected = [["..", "0.", "00", "00", "0.", "0.", ".0"], ["..", "..", ".0", ".0", "00", ".0", "00"], [".0", "..", "0.", "..", "0.", "..", ".0"]]
    braille_values = [["..", "..", ".0"], ["0.", "..", ".."], ["00", ".0", "0."], ["00", ".0", ".."], ["0.", "00", "0."], ["0.", ".0", ".."], [".0", "00", ".0"]]

    assert_equal expected, night_writer.format_translation(braille_values)
  end

  def test_format_lines
    night_writer = NightWrite.new

    three_lines = [["..", "0.", "00", "00", "0.", "0.", ".0"], ["..", "..", ".0", ".0", "00", ".0", "00"], [".0", "..", "0.", "..", "0.", "..", ".0"]]
    expected = ["..0.00000.0..0", ".....0.000.000", ".0..0...0....0"]

    assert_equal expected, night_writer.format_lines(three_lines)
  end

  def test_length_checker
    night_writer = NightWrite.new

    strings = ["0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.", "....................................................................................", "...................................................................................."]
    expected = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.
....................................................................................
....................................................................................
0.0.
....
...."

    assert_equal expected, night_writer.length_checker(strings)
  end



end
