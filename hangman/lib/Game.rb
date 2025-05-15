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
        data = JSON.load file
        Game.new(data['chosen_word'], data['total_lives'], data['right_letters'], data['wrong_letters'], data['current_lives'], data['turn_counter'])
    end
   
end