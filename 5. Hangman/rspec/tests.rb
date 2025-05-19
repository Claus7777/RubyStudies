# frozen_string_literal: true

require 'rspec/autorun'
require 'json'
require_relative 'lib/Game'
require_relative 'lib/SaveUtility'
include SaveUtility

describe Game do
  it 'create new game' do
    game = Game.new
    expect(game.chosen_word).not_to eq('')
  end

  it 'create new game with preselected word' do
    game = Game.new('test')
    expect(game.chosen_word).to eq('TEST')
  end

  it 'save game' do
    game = Game.new
    preselected_game = Game.new('test')
    saved_game = JSON.parse(SaveUtility.save_game(game))
    saved_presel_game = JSON.parse(SaveUtility.save_game(preselected_game))
    expect(saved_game['chosen_word']).not_to be_empty
    expect(saved_game).to include(
      'total_lives' => 7,
      'right_letters' => [''],
      'wrong_letters' => [''],
      'current_lives' => 7,
      'turn_counter' => 0
    )
    expect(saved_presel_game['chosen_word']).to eq('TEST')
    expect(saved_presel_game).to include(
      'total_lives' => 7,
      'right_letters' => [''],
      'wrong_letters' => [''],
      'current_lives' => 7,
      'turn_counter' => 0
    )
  end

  it 'load game and save it again' do
    game = Game.new
    game_word = game.chosen_word
    saved_game = SaveUtility.save_game(game)
    loaded_game = SaveUtility.load_game(saved_game)
    saved_game = JSON.parse(SaveUtility.save_game(loaded_game))
    expect(saved_game['chosen_word']).to eq(game_word)
    expect(saved_game).to include('total_lives' => 7,
                                  'right_letters' => [''], 'wrong_letters' => [''], 'current_lives' => 7, 'turn_counter' => 0)
  end

  it 'load game error' do
    saved_game = nil
    expect(SaveUtility.load_game(saved_game)).to eq('no implicit conversion of nil into String')
  end

  it 'load game invalid format' do
    saved_game = { 'hello' => 3, 'is there anybody in there' => 2 }.to_json
    expect { SaveUtility.load_game(saved_game) }.to raise_error(StandardError, 'Not a valid saved game.')
  end

  it 'load game with missing keys' do
    saved_game = { 'total_lives' => 7, 'right_letters' => [''], 'wrong_letters' => [''],
                   'current_lives' => 7 }.to_json
    expect { SaveUtility.load_game(saved_game) }.to raise_error(StandardError, 'Not a valid saved game.')
  end

  it 'load dictionary with fixed seed' do
    game = Game.new
    game.choose_word('C:\Users\pocar\Documents\Ruby\hangman\google-10000-english-usa.txt', 420)
    expect(game.chosen_word).to eq('roger')
  end

  it 'load dictionary with random seed' do
    game = Game.new
    game.choose_word('C:\Users\pocar\Documents\Ruby\hangman\google-10000-english-usa.txt')
    expect(game.chosen_word).not_to eq('')
  end

  it 'hide words' do
    game = Game.new('test')
    expect(game.hide_word).to eq(%w[_ _ _ _])
  end

  it 'guess letter' do
    game = Game.new('roger')
    game2 = Game.new('InConsTitucIonaLissimaMente')
    game2.right_letters = game2.hide_word
    game.right_letters = game.hide_word
    expect(game.check_letter('o')).to eq(%w[_ O _ _ _])
    expect(game2.check_letter('e')).to eq(%w[_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
                                             _ _ _ E _ E])
  end
end
