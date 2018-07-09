require_relative 'file_io'
require_relative 'braille_hash'

class NightRead
  include BrailleHash
  attr_reader :line_1, :line_2, :line_3, :line_1_braille, :line_2_braille, :line_3_braille, :braille_letters, :file_io, :english

  def initialize
    @file_io = FileIO.new
    @braille_to_alpha = BrailleHash.braille_hash.invert
    @line_1 = []
    @line_2 = []
    @line_3 = []
    @line_1_braille = []
    @line_2_braille = []
    @line_3_braille = []
    @braille_letters = []
  end

  def encode_file_to_english
    braille = file_io.read
    @english = encode_to_english(braille)
    file_io.write(english)
  end

  def encode_to_english(input)
    parse_braille_lines(input)
  end

  def parse_braille_lines(input)
    @line_1, @line_2, @line_3 = input.split(/\n/)
    format_braille_keys
  end

  def format_braille_keys
    @line_1_braille = line_1.scan(/../)
    @line_2_braille = line_2.scan(/../)
    @line_3_braille = line_3.scan(/../)

    index = 0
    until index > line_1_braille.length - 1
      @braille_letters << [line_1_braille[index], line_2_braille[index], line_3_braille[index]]
      index +=1
    end
    translate_to_english
  end

  def translate_to_english
    @braille_letters.map do |letter|
      @braille_to_alpha[letter]
    end.join
  end




end
