def stock_picker(array)
    days = []
    biggest_sell_day = 0
    biggest_sell_day_index = 0
    days_hash = {}

    array.each.with_index(1) do |buy_day, buy_day_index|
        array.each.with_index(1) do |sell_day, sell_day_index|
            if biggest_sell_day < sell_day && sell_day_index > buy_day_index
                biggest_sell_day = sell_day
                biggest_sell_day_index = sell_day_index
            end
        end
    days_hash[[buy_day_index, biggest_sell_day_index].to_s] = (biggest_sell_day - buy_day)
    biggest_sell_day = 0
    biggest_sell_day_index = 0
    end

    puts(days_hash)
    return days_hash.max_by{|key , value| value}.to_s
end

puts(stock_picker([17,3,6,9,15,8,6,1,10]))
