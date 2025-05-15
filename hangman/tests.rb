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

    it "load game" do
        game = Game.new("test", 7, [""], [""], 7, 0)
        saved_game = game.save_game
        expect(game.load_game(saved_game).save_game).to eq({"chosen_word"=>"test", "total_lives"=>7, "right_letters"=>[""], "wrong_letters"=>[""], "current_lives"=>7, "turn_counter"=>0}.to_json)
    end
end