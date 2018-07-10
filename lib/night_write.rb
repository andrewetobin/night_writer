require_relative 'file_io'
require_relative 'braille_hash'

class NightWrite
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

  def encode_to_braille(input)
    parsed = parse_text(input)
    braille_values = translate(parsed)
    format_translation(braille_values)
    format_lines
  end

  def parse_text(text)
    letters = text.chars
    letters.map do |letter|
      if ("A".."Z").include?(letter) && letter == letter.upcase
        letter = "caps", "#{letter.downcase}"
      else
        letter
      end
    end.flatten
  end

  def translate(parsed)
    parsed.map do |letter|
      @alpha_to_braille[letter]
    end
  end

  def format_translation(braille_values)
    formated = braille_values.map do |array|
      @line_1 << array[0]
      @line_2 << array[1]
      @line_3 << array[2]
    end
  end

  def format_lines
    line_1_as_string = line_1.join('')
    line_2_as_string = line_2.join('')
    line_3_as_string = line_3.join('')
    @all_lines = [line_1_as_string, line_2_as_string, line_3_as_string]

    if line_1_as_string.length > 80
      format_long_lines
    else
      all_lines.join("\n")
    end
  end

  def format_long_lines
    excess_lines = []
    all_lines.map do |line|
      line[0..79]
      excess_lines << line[80..-1]
    end
    @all_lines += excess_lines
    all_lines.join("\n")
  end
end
