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

    selector = Kernel.gets.match(/\d+/)[0]
    selector = selector.to_i
    raise "Invalid choice. Try again." if selector != 1 || selector != 2
    rescue StandardError => e
        puts e
        retry
    else
        if selector == 1
            game = Game.new(7, [''], [''], 7, 0)
            ##TODO: the rest of the game logic
        else
            #TODO: logic to select a file
            game = SaveUtility::load_game('placeholder')
        end
    end


end
