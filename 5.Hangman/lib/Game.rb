# frozen_string_literal: true

class Game
  attr_accessor :chosen_word, :total_lives, :right_letters, :wrong_letters, :current_lives, :turn_counter,
                :end_game_flag

  MAX_LIFE = 7
  WORD_BOTTOM_SIZE = 5
  WORD_UPPER_SIZE = 12
  DICTIONARY = File.expand_path('../google-10000-english-usa.txt', __dir__)

  def initialize(chosen_word = '', total_lives = MAX_LIFE, right_letters = [''], wrong_letters = [],
                 current_lives = MAX_LIFE, turn_counter = 0)
    chosen_word = choose_word(DICTIONARY) if chosen_word == ''
    @chosen_word = chosen_word.upcase
    @total_lives = total_lives
    @right_letters = right_letters.map(&:upcase)
    @wrong_letters = wrong_letters.map(&:upcase)
    @current_lives = current_lives
    @turn_counter = turn_counter
    @end_game_flag = false
  end

  def hide_word
    @right_letters = ['_'] * chosen_word.length
    right_letters
  end

  def check_letter(guessed_letter)
    guessed_letter = guessed_letter.upcase
    right_guess = false
    chosen_word.chars.each_with_index do |letter, index|
      if letter == guessed_letter
        @right_letters[index] = guessed_letter
        right_guess = true
      end
    end
    return right_letters if right_guess


    @current_lives = current_lives - 1
    @wrong_letters = wrong_letters.push(guessed_letter)
    -1
  end

  def choose_word(dictionary, seed = 0)
    word_seed = if seed.zero?
                  Random.new
                else
                  Random.new(seed)
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

  def print_guesses
    puts
    puts "WORD: #{right_letters}"
    return unless wrong_letters.length >= 1

    puts "WRONG GUESSES: #{wrong_letters}"
  end
end
