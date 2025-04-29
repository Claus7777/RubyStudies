def caesar_cipher(string, shift)
    result = []
    string.each_char do |char|
        if char.match(/[[:alpha:]]/)
            if ((char.ord <= 90 ) && (char.ord + shift > 90)) || ((char.ord <= 122) && (char.ord + shift > 122))
                result.push((char.ord - (26 - shift)).chr)
            else 
                result.push((char.ord + shift).chr)
            end
        else
            result.push(char)
        end
    end
    return result.join()
end

puts("Digite a palavra ou frase para ser encriptada:")
variavel = gets.chomp()
puts("Digite por quantas letras você quer que o shift seja:")
shift = ""
until shift.match(/[[:digit:]]/)
    shift = gets.chomp()
    unless shift.match(/[[:digit:]]/)
        puts("Isso não é um numero. Tente de novo")
    end
end

puts(caesar_cipher(variavel, shift.to_i))