require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'

class NightWriterTest < Minitest::Test

  def test_it_exists
    night_writer = NightWriter.new

    assert_instance_of NightWriter, night_writer
  end

  def test_it_can_translate_one_letter
    night_writer = NightWriter.new

    assert_equal [['0.','00','..']], night_writer.translate("h")
  end

  def test_it_two_multiple_letters
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
