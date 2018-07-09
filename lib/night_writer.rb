require_relative 'file_io'
require_relative 'night_write'

night_writer = NightWrite.new
night_writer.encode_file_to_braille
