require './lib/file_io'
require './lib/night_write'

night_writer = NightWrite.new
night_writer.encode_file_to_braille
