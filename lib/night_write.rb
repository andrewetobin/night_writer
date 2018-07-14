require_relative 'file_io'
require_relative 'braille_hash'

class NightWrite
  include BrailleHash
  attr_reader :file_io, :all_lines

  def initialize
    @alpha_to_braille = BrailleHash.braille_hash
    @file_io = FileIO.new
  end

  def encode_file_to_braille
    plain = file_io.read.chomp
    braille = encode_to_braille(plain)
    file_io.write(braille)
  end

  def encode_to_braille(input)
    parsed = parse_text(input)
    braille_values = translate(parsed)
    three_lines = format_translation(braille_values)
    strings = format_lines(three_lines)
    length_checker(strings)
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
    braille_values.transpose
  end

  def format_lines(three_lines)
    lines = []
    three_lines.each do |line|
      lines << line.join
    end
    lines
  end

  def length_checker(strings)
    if strings[0].length > 80
      format_long_lines(strings)
    else
      strings.join("\n")
    end
  end

  def format_long_lines(strings)
    excess_lines = []
    strings.map do |line|
      line[0..79]
      excess_lines << line[80..-1]
    end
    strings += excess_lines
    strings.join("\n")
  end

end
