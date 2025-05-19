# frozen_string_literal: true

require_relative 'lib/Game'
require_relative 'lib/SaveUtility'
include SaveUtility

# #Requerimentos:
## Todo turno, o jogador pode escolher entre tentar adivinhar uma letra ou salvar o jogo
## O jogo acaba quando acabarem as vidas do jogador (7?) ou quando a palavra for totalmente acertada

# #Funcoes:
## Ler uma letra do usuário do console, verificar se é uma letra mesmo. Se não for, tentar de novo. Se for, formatar input para ser minúsculo.
## Pegar essa letra, verificar se ela está na palavra. Se sim, mostrar a letra na palavra. Se não, botar no array de letras apostadas e tirar uma vida.

def game_master
    begin
    puts "Welcome to Hangman! Would you like start a new game or load a saved game?"
    puts "1 - NEW GAME"
    puts "2 - LOAD GAME"

    selector = gets.chomp
    selector = selector.to_i
    raise "Invalid choice. Try again." if selector != 1 && selector != 2
    rescue StandardError => e
        puts e
        retry
    else
        if selector == 1
            game = Game.new
            game.turn_counter = 1
            game.hide_word()
            game.print_guesses
            game_loop(game)
        else
            #TODO: logic to select a file
            game = SaveUtility::load_game('placeholder')
            game_loop(game)
        end
    end
    puts("GAME OVER!")
end

def game_loop(game)
    while game.end_game_flag == false
        puts "## TURN " + game.turn_counter.to_s + " ##"
        puts
        puts "--LIVES LEFT " + game.current_lives.to_s + "--"

        begin
          puts "Guess a letter: "
          letter = Kernel.gets.match(/[a-zA-Z]/)&.[](0)
          raise "Invalid selection" if letter == nil
        rescue StandardError => e
            puts e
            retry
        else
            try = game.check_letter(letter)
          unless try == -1
            game.print_guesses
          else
            puts
            puts "WRONG GUESS"
            puts "LIVES REMAINING: " + game.current_lives.to_s
            game.print_guesses
          end
        end
        
        if !game.right_letters.include?("_") || game.current_lives <= 0
            game.end_game_flag = true
        end
        game.turn_counter += 1
    end
end

game_master