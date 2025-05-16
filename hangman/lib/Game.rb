require 'json'

class Game
    attr_accessor :chosen_word, :total_lives, :right_letters, :wrong_letters, :current_lives, :turn_counter

    def initialize(chosen_word, total_lives, right_letters, wrong_letters, current_lives, turn_counter)
        @chosen_word = chosen_word
        @total_lives = total_lives
        @right_letters = right_letters
        @wrong_letters = wrong_letters
        @current_lives = current_lives
        @turn_counter = turn_counter
    end

    def save_game
        JSON.dump({
            :chosen_word => @chosen_word,
            :total_lives => @total_lives,
            :right_letters => @right_letters,
            :wrong_letters => @wrong_letters,
            :current_lives => @current_lives,
            :turn_counter => @turn_counter
        })
    end

    def load_game(file)
        ##TODO: Rescue loop caso o arquivo não seja JSON, não seja válido, ou não seja um JSON de arquivo de jogo
        begin
            data = JSON.parse(file)     
            unless data.has_key?('chosen_word') && data.has_key?('total_lives') && data.has_key?('right_letters') && data.has_key?('wrong_letters') && data.has_key?('current_lives') && data.has_key?('turn_counter')
                raise StandardError.new "Not a valid saved game."
            end
        rescue JSON::ParserError, TypeError => e
            return e.to_s
        else 
            Game.new(data['chosen_word'], data['total_lives'], data['right_letters'], data['wrong_letters'], data['current_lives'], data['turn_counter'])
        end
    end
   
end