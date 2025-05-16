# frozen_string_literal: true

class Game
  attr_accessor :chosen_word, :total_lives, :right_letters, :wrong_letters, :current_lives, :turn_counter

  WORD_BOTTOM_SIZE = 5
  WORD_UPPER_SIZE = 12
  DICTIONARY = File.expand_path('../google-10000-english-usa.txt', __dir__)

  def initialize(chosen_word = '', total_lives, right_letters, wrong_letters, current_lives, turn_counter)
    if chosen_word == ''
        @chosen_word = choose_word(DICTIONARY)
    else 
        @chosen_word = chosen_word
    end
    @total_lives = total_lives
    @right_letters = right_letters
    @wrong_letters = wrong_letters
    @current_lives = current_lives
    @turn_counter = turn_counter
  end

  def choose_word(dictionary, seed = 0)
    if seed == 0
      word_seed = Random.new()
    else 
      word_seed = Random.new(seed)
    end

    begin
      word_index = word_seed.rand(1..10_000)
      selected_word = File.readlines(dictionary)[word_index]
      if selected_word.length < WORD_BOTTOM_SIZE || selected_word.length > WORD_UPPER_SIZE
        raise StandardError, 'Word not the right size. Doing again'
      end
    rescue StandardError
      retry
    else
      @chosen_word = selected_word.chomp
    end
  end
end
