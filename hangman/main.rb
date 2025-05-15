##Requerimentos:
## Carregar o dicionário, escolher uma palavra aleatória entre 5 e 12 caracteres de tamanho
## Quando o programa carrega pela primeira vez, perguntar se o Jogador quer carregar algum de seus jogos salvos
## Todo turno, o jogador pode escolher entre tentar adivinhar uma letra ou salvar o jogo
## O jogo acaba quando acabarem as vidas do jogador (7?) ou quando a palavra for totalmente acertada

##Funcoes:
## Carregar o dicionario
## Ir para um numero aleatorio entre 1 e 10000. Ver se essa palavra é maior que 5 e menor que 12. Se sim, ir pro próximo passo. Se não, tentar de novo
## Pegar o estado atual do jogo: Palavra escolhida, letras acertadas, vidas totais, vidas usadas, numero do turno, quais letras já foram arriscadas e não estão nas palavras
## Carregar um JSON com os fields: Palavra escolhida, letras acertadas, vidas totais, vidas usadas, numero do turno, letras apostadas em um game state
## Ler uma letra do usuário do console, verificar se é uma letra mesmo. Se não for, tentar de novo. Se for, limpar input para ser minúsculo.
## Pegar essa letra, verificar se ela está na palavra. Se sim, mostrar a letra na palavra. Se não, botar no array de letras apostadas e tirar uma vida.

def game_master
    
end