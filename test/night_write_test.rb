require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'

class NightWriteTest < Minitest::Test

  def test_it_exists
    night_writer = NightWrite.new

    assert_instance_of NightWrite, night_writer
  end

  def test_parse_text
    skip #need to setup runner
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
    night_writer_2 = NightWrite.new
    assert_equal "..0.\n....\n.0..", night_writer.encode_to_braille("A")
    assert_equal "..0.\n..00\n.0..", night_writer_2.encode_to_braille("H")
  end



end