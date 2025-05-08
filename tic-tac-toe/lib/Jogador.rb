# frozen_string_literal: true

class Jogador
  attr_reader :symbol, :color

  def initialize(player_symbol, color)
    @symbol = player_symbol
    @color = color
  end
end
