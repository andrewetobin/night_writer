file = File.open(ARGV[0],"r")

incoming_text = file.read

file.close

capitalized_text = incoming_text.upcase

writer = File.open(ARGV[1],"w")

writer.write(capitalized_text)

writer.close

read_new = File.open(ARGV[1],"r")

number_of_characters = (read_new.read.length) - 1

puts "Created '#{ARGV[1]}' containing #{number_of_characters} characters"
