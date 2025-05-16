require 'rspec/autorun'
require 'json'
require_relative 'lib/Game.rb'

describe Game do
    it "create new game" do
        game = Game.new("test", 7, [""], [""], 7, 0)
        expect(game.chosen_word).to eq("test")
    end

    it "save game" do 
        game = Game.new("test", 7, [""], [""], 7, 0)
        expect(game.save_game).to eq({"chosen_word"=>"test", "total_lives"=>7, "right_letters"=>[""], "wrong_letters"=>[""], "current_lives"=>7, "turn_counter"=>0}.to_json)
    end

    it "load game and save it again" do
        game = Game.new("test", 7, [""], [""], 7, 0)
        saved_game = game.save_game
        expect(game.load_game(saved_game).save_game).to eq({"chosen_word"=>"test", "total_lives"=>7, "right_letters"=>[""], "wrong_letters"=>[""], "current_lives"=>7, "turn_counter"=>0}.to_json)
    end

    it "load game error" do 
        game = Game.new("test", 7, [""], [""], 7, 0)
        saved_game = nil
        expect(game.load_game(saved_game)).to eq("no implicit conversion of nil into String")
    end

    it 'load game invalid format' do
        game = Game.new("test", 7, [""], [""], 7, 0)
        saved_game = {"hello" => 3, "is there anybody in there" => 2}.to_json
        expect{game.load_game(saved_game)}.to raise_error( StandardError, "Not a valid saved game." )
    end

    it 'load game with missing keys' do
        game = Game.new("test", 7, [""], [""], 7, 0)
        saved_game = {"total_lives"=>7, "right_letters"=>[""], "wrong_letters"=>[""], "current_lives"=>7}.to_json
        expect{game.load_game(saved_game)}.to raise_error( StandardError, "Not a valid saved game." )
    end
end