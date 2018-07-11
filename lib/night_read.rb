require_relative 'file_io'
require_relative 'braille_hash'

class NightRead
  include BrailleHash
  attr_reader :braille_letters, :file_io, :english_letters


  def initialize
    @file_io = FileIO.new
    @braille_to_alpha = BrailleHash.braille_hash.invert
    @braille_letters = []
    @english_letters = []
  end

  def encode_file_to_english
    braille = file_io.read
    english = encode_to_english(braille)
    file_io.write(english)
  end

  def encode_to_english(input)
    three_strings = parse_braille_lines(input)
    letters_in_braille = format_braille_keys(three_strings)
    braille_keys = braille_keys(letters_in_braille)
    letters_in_english = translate_to_english(braille_keys)
    capitalize(letters_in_english)
  end

  def parse_braille_lines(input)
    input.split("\n")
  end

  def format_braille_keys(three_strings)
    chunks = three_strings.map do |string|
      string.scan(/../)
    end
    chunks
  end

  def braille_keys(chunks)
    line_1 = chunks[0]
    line_2 = chunks[1]
    line_3 = chunks[2]
    index = 0
    until index > line_1.length - 1
      @braille_letters << [line_1[index], line_2[index], line_3[index]]
      index +=1
    end
    return @braille_letters
  end

  def translate_to_english(letters_in_braille)
    letters_in_english = letters_in_braille.map! do |letter|
      @braille_to_alpha[letter]
    end
    return letters_in_english
  end

  def capitalize(letters_in_english)
    letters_in_english.map.with_index do |letter, index|
      if letter == "caps"
        letter = letters_in_english[index + 1].upcase
        letters_in_english.delete_at(index + 1)
        letter
      else
        letter
      end
    end.join
  end
end
