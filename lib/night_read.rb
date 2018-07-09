require_relative 'file_io'
require_relative 'braille_hash'

class NightRead
  include BrailleHash
  attr_reader :line_1, :line_2, :line_3

  def initialize
    @braille_to_alpha = BrailleHash.braille_hash.invert
    @line_1 = []
    @line_2 = []
    @line_3 = []
    @line_1_braille = []
    @line_2_braille = []
    @line_3_braille = []
  end





end
