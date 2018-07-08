require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'

class NightWriterTest < Minitest::Test

  def test_it_exists
    night_writer = NightWriter.new

    assert_instance_of NightWriter, night_writer
  end

  def test_parse_text
    skip
    night_writer = NightWriter.new

    expected = ["caps", "h", "e", "l", "l", "o", " ", "caps", "w", "o", "r", "l", "d"]
    assert_equal expected, night_writer.parse_text("Hello World")
  end

  def test_it_can_encode_one_letter
    night_writer = NightWriter.new
    night_writer2 = NightWriter.new

    assert_equal "0.\n..\n..", night_writer.encode_to_braille("a")
    assert_equal "0.\n00\n..", night_writer2.encode_to_braille("h")
  end
  
  def test_it_can_translate_one_letter
    skip
    night_writer = NightWriter.new

    assert_equal [['0.','00','..']], night_writer.translate("h")
  end

  def test_it_two_multiple_letters
    skip
    night_writer = NightWriter.new
    expected = [["0.", "00", ".."], ["0.", ".0", ".."]]
    assert_equal expected, night_writer.translate("he")
  end

  def test_it_can_return_braille_in_grid
    skip
    night_writer = NightWriter.new
    night_writer.translate("he")

     night_writer.format_translation(['0.','00','..'])
  end



end
