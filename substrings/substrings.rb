def substrings(string, dictionary)
  result_hash = {}
  string_array = string.downcase.split(/ /)
  dictionary.each do |word|
    string_array.each do |string_part|
      if string_part[word]
        if result_hash[word].nil?
          result_hash[word] = 1
        else
          result_hash[word] += 1
        end
      end
    end
  end
  result_hash
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
puts(substrings("Howdy partner, sit down! How's it going?", dictionary))
