def caesar_cipher(string, shift)
  result = []
  string.each_char do |char|
    if char.match(/[[:alpha:]]/)
      if ((char.ord <= 90) && (char.ord + shift > 90)) || ((char.ord <= 122) && (char.ord + shift > 122))
        result.push((char.ord - (26 - shift)).chr)
      else
        result.push((char.ord + shift).chr)
      end
    else
      result.push(char)
    end
  end
  result.join
end

puts('Write the word or message you want to encrypt:')
variavel = gets.chomp
puts('By how many letters do you want the cipher to shift?')
shift = ''

until shift.match(/[[:digit:]]/)
  shift = gets.chomp
  puts('That\'s not a number, is it?') unless shift.match(/[[:digit:]]/)
end

puts(caesar_cipher(variavel, shift.to_i))
