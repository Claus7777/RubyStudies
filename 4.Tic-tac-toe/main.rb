# frozen_string_literal: true

require_relative 'lib/Jogador'
require 'colorize'

def initialize_board(rows, columns)
  Array.new(rows) { Array.new(columns, ' ') }
end

def check_game_state(board)
  (0..2).each do |row|
    next if board[row][0] == ' '
    return true if board[row][0] == board[row][1] && board[row][1] == board[row][2]
  end

  (0..2).each do |col|
    next if board[0][col] == ' '
    return true if board[0][col] == board[1][col] && board[1][col] == board[2][col]
  end

  if (board[1][1] != ' ') && ((board[0][0] == board[1][1] && board[1][1] == board[2][2]) ||
       (board[0][2] == board[1][1] && board[1][1] == board[2][0]))
    return true
  end

  board.flatten.none? { |cell| cell == ' ' }
end

def register_play(board, play, symbol)
  board[play[0]][play[1]] = symbol
end

def draw_board(board, players)
  puts(board.to_a.map do |row|
    row.map do |cell|
      if cell.to_s != ' '
        cell.to_s.include?(players[0].symbol) ? cell.to_s.colorize(players[0].color) : cell.to_s.colorize(players[1].color)
      else
        cell
      end
    end.join(' ')
  end)
end

def print_final_board(board); end

def process_play(jogador)
  puts "It's your turn - #{jogador.symbol} PLAYER"
  puts 'Choose the column (1 - 3)'
  coluna = Kernel.gets.match(/\d+/)[0]
  coluna = coluna.to_i
  raise 'Exception: Invalid number' if coluna < 1 || coluna > 3
rescue Exception => e
  puts e
  retry
else
  begin
    puts 'Choose the line (1 - 3)'
    linha = Kernel.gets.match(/\d+/)[0]
    linha = linha.to_i
    raise 'Exception: Invalid number' if linha < 1 || linha > 3
  rescue Exception => e
    puts e
    retry
  else
    puts 'Processing play...'
    [linha - 1, coluna - 1]
  end
end

xis = Jogador.new('X', :blue)
circulo = Jogador.new('O', :red)
players = [xis, circulo]
tabuleiro = initialize_board(3, 3)

turn_counter = 0
loop do
  active_player = players[turn_counter % 2]
  begin
    play = process_play(active_player)
    raise 'Invalid play. Try again.' if tabuleiro[play[0]][play[1]] != ' '
  rescue Exception => e
    puts e
    retry
  end
  register_play(tabuleiro, play, active_player.symbol)
  draw_board(tabuleiro, players)
  turn_counter += 1
  break if check_game_state(tabuleiro) == true && turn_counter != 1
end

puts 'Game Over!'
print_final_board(tabuleiro)
