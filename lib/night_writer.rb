require_relative 'file_io'
require_relative 'braille_hash'

class NightWriter
  include BrailleHash
  attr_reader :line_1, :line_2, :line_3, :file_io, :all_lines
  attr_accessor :braille

  def initialize
    @alpha_to_braille = BrailleHash.braille_hash
    @line_1 = []
    @line_2 = []
    @line_3 = []
    @file_io = FileIO.new
  end

  def encode_file_to_braille
    plain = file_io.read.chomp
    @braille = encode_to_braille(plain)
    file_io.write(braille)
  end

  def translate(string)
    letters = string.chars
    arrays = letters.map do |letter|
      @alpha_to_braille[letter]
    end
    format_translation(arrays)
    # format_translation(value)
  end

  def format_translation(arrays)
    formated = arrays.map do |array|
      @line_1 << array[0]
      @line_2 << array[1]
      @line_3 << array[2]
    end

  end
end

night_writer = NightWriter.new
puts night_writer.translate("he")
puts night_writer.line_1
puts night_writer.line_2
puts night_writer.line_3
