# frozen_string_literal: true

require 'json'
require_relative 'Game'

module SaveUtility
  def self.save_game(game)
    JSON.dump({
                chosen_word: game.chosen_word,
                total_lives: game.total_lives,
                right_letters: game.right_letters,
                wrong_letters: game.wrong_letters,
                current_lives: game.current_lives,
                turn_counter: game.turn_counter
              })
  end

  def self.load_game(file)
    data = JSON.parse(file)
    unless data.key?('chosen_word') && data.key?('total_lives') && data.key?('right_letters') && data.key?('wrong_letters') && data.key?('current_lives') && data.key?('turn_counter')
      raise StandardError, 'Not a valid saved game.'
    end
  rescue JSON::ParserError, TypeError => e
    e.to_s
  else
    Game.new(data['chosen_word'], data['total_lives'], data['right_letters'], data['wrong_letters'],
             data['current_lives'], data['turn_counter'])
  end
end
