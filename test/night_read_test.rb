require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_read'

class NightReadTest < Minitest::Test

  def test_it_exists
    nr = NightRead.new

    assert_instance_of NightRead, nr
  end


end
