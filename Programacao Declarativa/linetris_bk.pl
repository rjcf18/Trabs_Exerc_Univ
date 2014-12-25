/* predicado dinâmico para definir mais tarde quem ganhou o jogo, usando asserts
   e retracts */
:-dynamic(ganhou/1).

%inicializacao do tabuleiro
inicializar(Nlinhas, Ncolunas, Matriz) :-
   length(Matriz, Nlinhas),  % cria uma lista de aridade N
   cria_linhas(Ncolunas,Matriz).

/* Em cada posição da lista irá criar uma sublista de aridade M com
elementos não instanciados (não atómicos). */
cria_linhas(_,[]).
cria_linhas(Ncolunas,[L|Ls]) :-
   length(L,Ncolunas),
   cria_linhas(Ncolunas, Ls).

/* instancia a variável na posição(X,Y) com um elemento E, ou, caso lá esteja um
  elemento atómico, devolve o elemento E que se encontra nessa posição */
posicao(X,Y,E,Matriz):-
	nth1(X,Matriz,LinhaX),
	nth1(Y,LinhaX,E).

/* faz um findall de todos os valores não atómicos da coluna pretendida para uma
  lista e o tamanho dessa lista irá ser a linha exacta onde instanciar com a
  peca a inserir. Caso já todos os elementos dessa coluna estejam instanciados,
  ou seja, caso sejam todos atómicos, o predicado falha.*/
insere(Peca,Coluna,Matriz):-
	findall(E,(posicao(_,Coluna,E,Matriz), \+ atomic(E)),L), length(L,N),
  (\+ all_atomic(L),posicao(N,Coluna,Peca,Matriz));(fail).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%loop menu PRINCIPAL

menu:-
	nl,write('###########################\n'),
     write(' ####  MENU PRINCIPAL ####\n'),
	   write('###########################\n\n'),
     write('      ### Linetris ###\n\n'),
	    write('    0 - Sair\n'),
      write('    1 - Humano vs Humano\n'),
      write('    2 - Humano vs AI\n\n'),
  write('Insira o número correspondente à opção:\n'),
  read(Opc), write(Opc),menuOpt(Opc).

% caso de escolha da opção 1 (Humano vs humano)
menuOpt(1):-
	write('\n\nInsira as dimensões N e M (NxM):\n\n'),
      write('N? \n'), read(Nlinhas), write(Nlinhas),
  write('\n\nM? \n'), read(Ncolunas), write(Ncolunas), nl,
  ((integer(Nlinhas),integer(Ncolunas), Nlinhas > 3,Ncolunas > 3,
     inicializar(Nlinhas,Ncolunas,Matriz), ciclo(1,Matriz,hvsh));menuOpt(1)).

%caso de escolha da opção 2 (Humano vs AI)
menuOpt(2):-
	write('\n\nInsira as dimensões N e M (NxM):\n\n'),
      write('N? \n'), read(Nlinhas), write(Nlinhas),
  write('\n\nM? \n'), read(Ncolunas), write(Ncolunas), nl,
  ((integer(Nlinhas), integer(Ncolunas),Nlinhas > 3,Ncolunas > 3,
     subMenu(Nlinhas,Ncolunas));menuOpt(2)).

%saida do menu
menuOpt(0):-!.

%casos em que não é inserido nenhum dos números desejados
menuOpt(_):-
	nl, menu.

%submenu do modo humano vs AI - input primeiro a jogar
subMenu(N,M):-
  write('\nJogador inicial:\n'),
    write('     1 - Humano\n'),
    write('     2 - AI\n\n'),
    write('Insira o número correspondente à opção:\n'), read(J),write(J),nl,
  (integer(J),between(1,2,J), inicializar(N,M,Matriz),ciclo(J,Matriz,hvsc));
   (subMenu(N,M)).

 /* ciclos modo humano vs humano e humano vs AI. Jogador 1 é sempre as peças pretas
 e o jogador 2 e AI são sempre as peças brancas */

% primeira coisa no ciclo é verificar o terminal do jogo (se alguém ganhou)
ciclo(_,Matriz,Modo):-
  verifica_terminal(Matriz), !, print_tabuleiro(Matriz),
  ((Modo = hvsh,write('O vencedor é o jogador: '), ganhou(J), write(J));
  (Modo = hvsc, write('O vencedor é: '), ganhou(X), player_AI(X,J),write(J))).

/* caso não haja condições de vitória a 2a verificação a fazer é se a última
linha do tabuleiro se encontra preenchida, caso esteja é necessário
eliminá-la e descer as restantes linhas para baixo*/
ciclo(Jogador,Matriz,Modo):-
  length(Matriz,Nlinhas),nth1(Nlinhas,Matriz,UltimaLinha),
  all_atomic(UltimaLinha), desce_tabuleiro(Matriz,Nlinhas,NovaMatriz),
  ciclo(Jogador,NovaMatriz,Modo).

% jogador 1 a jogar, caso a inserção falhe é pedido input novamente ao jogador 1
ciclo(1,Matriz,Modo):-
  print_tabuleiro(Matriz),
  write('Jogador 1 insira a coluna onde jogar: \n'),
  read(Coluna), write(Coluna), nl,
  (insere(p,Coluna,Matriz), ciclo(2,Matriz,Modo));(ciclo(1,Matriz,Modo)).

/* jogador 2 a jogar (modo humano vs humano), caso a inserção falhe é pedido
input novamente ao jogador 2*/
ciclo(2,Matriz,hvsh):-
  print_tabuleiro(Matriz),
  write('Jogador 2 insira a coluna onde jogar: \n'),
  read(Coluna), write(Coluna),nl,
  (insere(b,Coluna,Matriz), ciclo(1,Matriz,hvsh));(ciclo(2,Matriz,hvsh)).

 /* jogador 2 (AI) a jogar (modo humano vs AI). São encontrados todos os pares
 Valor-Coluna cujo valor é determinado usando uma função de avaliação (heurística),
 e é seleccionado o par com o maior valor da lista resultante sendo o segundo
 valor do par a coluna onde a peça irá ser jogada pela AI*/
 ciclo(2,Matriz,hvsc):-
   print_tabuleiro(Matriz),
   write('AI a calcular jogada... \n'),
   nth1(1,Matriz,Linha),
   length(Linha, Ncolunas),
   geraNumsI_J(1,Ncolunas,Colunas),
   findall(Valor-Coluna2, ( member(Coluna1,Colunas),insere(b,Coluna1,Matriz),
                            func_aval((Matriz,b),Valor1),
                            member(Coluna2,Colunas),insere(p,Coluna2,Matriz),
                            func_aval((Matriz,b),Valor2),Valor is Valor1+Valor2
                          ), Lista),
   max_member(_-Coluna,Lista),
   insere(b,Coluna,Matriz),
   write('\nAI a jogar na coluna: '),
   write(Coluna),nl,
   ciclo(1,Matriz,hvsc).

% gera uma lista com todos os numeros de I a J (inclusivé)
geraNumsI_J(I,J,L):-
   findall(N, between(I,J,N), L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%faz um print do tabuleiro
print_tabuleiro(T):-
	nl,print_linhas(T),nl.

/* para cada linha da matriz imprime todos os elementos dessa linha e passa à
   proxima até chegar ao fim da matriz*/
print_linhas([]).
print_linhas([L|Ls]) :-
	write('      | '),print_elementos(L),nl,nl, print_linhas(Ls).

% imprime todos os elementos de uma linha
print_elementos([]).
print_elementos([E|Es]):-
	( (\+ atomic(E), write('.'));(atomic(E), write(E)) ),
  write(' | '), print_elementos(Es).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% verifica se todos os elementos de uma lista são atómicos
all_atomic([]).
all_atomic([X|Xs]):-
  atomic(X), all_atomic(Xs).

% remove_nth(N,L1,L2)
% remove o elemento na posicao N duma lista. L2 é a lista resultante
% da remoção do elemento à posicao N da lista L1
remove_nth(1,[_|Xs],Xs).
remove_nth(N,[Y|Xs],[Y|Ys]):- N > 1,
  N1 is N - 1, remove_nth(N1,Xs,Ys).

%remove a ultima linha e cria uma nova linha no inicio da matriz
desce_tabuleiro(Matriz,Ncolunas,Matriz3):-
  nth1(Ncolunas,Matriz,UltimaLinha), remove_nth(Ncolunas,Matriz,Matriz2),
  length(UltimaLinha,N1), length(NovaLinha,N1),
  append([NovaLinha],Matriz2,Matriz3),!.

/* predicado para controlar qual o jogador 1 e jogador 2 durante o
  ciclo do modo humano vs AI*/
player_AI(1,'Jogador 1').
player_AI(2,'AI').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%guarda quem ganhou o jogo
guarda(ganhou(P)):- retractall(ganhou(_)), asserta(ganhou(P)).

% conta o número de peças brancas ou peças pretas numa lista e guarda quem
% ganhou se algum dos jogadores tiver 4 peças seguidas, caso chegue ao fim da
% lista e nao haja 4 pecas seguidas, o predicado falha
ver_pecas(_,4,_):- guarda(ganhou(1)),!.
ver_pecas(_,_,4):- guarda(ganhou(2)),!.
ver_pecas([],Np,Nb):- Np < 4, Nb < 4, fail.

ver_pecas([E|Es],_,_):- \+ atomic(E),ver_pecas(Es,0,0).

ver_pecas([E|Es],Np,Nb):-
  atomic(E), (E == p, Np1 is Np + 1,ver_pecas(Es,Np1,Nb));
             (E == b, Nb1 is Nb + 1,ver_pecas(Es,Np,Nb1)).

% verifica as linhas, colunas e diagonais. predicado falha se nenhum dos jogadores
% estiver em condições de vitória
verifica_terminal(Matriz):-
	verifica_linhas(Matriz);
  (nth1(1,Matriz,Linha), length(Linha,Ncolunas),
    verifica_colunas(Matriz,Ncolunas) );
  (verifica_diagonais(Matriz) ).

verifica_linhas([]):-!,fail.
verifica_linhas([L|Ls]):-
  ver_pecas(L,0,0);verifica_linhas(Ls).

verifica_colunas(Matriz,N):-
  N > 0, findall(E, posicao(_,N,E,Matriz),L),
  ((ver_pecas(L,0,0),!); (N2 is N-1,verifica_colunas(Matriz,N2))).

/* verifica todas as diagonais para o jogador 1 e jogador 2*/
verifica_diagonais(Matriz):-
  (check_diags(Matriz,p),guarda(ganhou(1)));
  (check_diags(Matriz,b),guarda(ganhou(2))).

check_diags(M,J):-
  findall((p(X,Y),E), (posicao(X,Y,E,M),atomic(E)), L),
  findall(J, encontra(L,J), L2),length(L2, V), V > 0.

encontra(L,J):-
  member((p(X,Y), J), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2, X3 is X+3, Y3 is Y+3,
  member((p(X1,Y1),J), L), member((p(X2,Y2),J), L), member((p(X3,Y3),J), L).

encontra(L,J):-
  member((p(X,Y), J), L),
  X1 is X+1, X2 is X+2, X3 is X+3, Y1 is Y-1, Y2 is Y-2, Y3 is Y-3,
  member((p(X1,Y1),J), L), member((p(X2,Y2),J), L), member((p(X3,Y3),J), L).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% conta o numero total de 1p's ou 1b's
find_all_1peca(M, J, V):-
  %encontra todos os membros atomicos do estado
  findall((p(X,Y),E), (posicao(X,Y,E,M),atomic(E)), L),
  findall(J, find_1peca(L, J), L2),length(L2, V).

% encontrar num. de 1p's ou 1b's
find_1peca(L, J):-
  member((p(X,Y), J), L),
  X1 is X+1, X2 is X-1,Y1 is Y-1, Y2 is Y+1,
  \+ member((p(X,Y1),J), L), \+ member((p(X,Y2),J), L), \+ member((p(X1,Y),J), L),
  \+ member((p(X2,Y),J), L), \+ member((p(X1,Y1),J), L), \+ member((p(X2,Y2),J), L),
  \+ member((p(X1,Y2),J), L), \+ member((p(X2,Y1),J), L).

% conta o numero total de 2p's ou 2b's
find_all_2pecas(M, J, V):-
  findall((p(X,Y),E), (posicao(X,Y,E,M),atomic(E)), L),
  findall(J, find_2pecas(L, J), L2),length(L2, V).

% encontrar num. de 2p's ou 2b's na linha
find_2pecas(L, J):-
  member((p(X,Y), J), L),
  Y1 is Y-1,Y2 is Y-2,
  member((p(X,Y1),J), L), member((p(X,Y2),J), L),(\+ atomic(J1); \+ J1=J).

% encontrar num. de 2p's ou 2b's na coluna
find_2pecas(L, J):-
  member((p(X,Y), J), L),
  X1 is X-1, X2 is X-2,
  member((p(X1,Y),J), L),member((p(X2,Y),J1), L),(\+ atomic(J1); \+ J1=J).

%diagonal 1
find_2pecas(L, J):-
  member((p(X,Y), J), L),
  X1 is X-1, Y1 is Y-1,X2 is X-2, Y2 is Y-2,
  member((p(X1,Y1),J), L),member((p(X2,Y2),J1), L),(\+ atomic(J1); \+ J1=J).

%diagonal 2
find_2pecas(L, J):-
  member((p(X,Y), J), L),
  X1 is X-1, Y1 is Y+1,X2 is X-2,Y2 is Y-2,
  member((p(X1,Y1),J), L),member((p(X2,Y2),J1), L),(\+ atomic(J1); \+ J1=J).

% conta o numero total de 3p's ou 3b's
find_all_3pecas(M, J, V):-
  findall((p(X,Y),E), (posicao(X,Y,E,M),atomic(E)), L),
  findall(J, find_3pecas(L, J), L2),length(L2, V).

% encontrar num. de 3p's ou 3b's na linha
find_3pecas(L, J):-
  member((p(X,Y), J), L),
  Y1 is Y+1, Y2 is Y+2, Y3 is Y+3, member((p(X,Y1),J), L),
  member((p(X,Y2),J), L), member((p(X,Y3),J1), L), (\+ atomic(J1); \+ J1=J).

% encontrar num. de 3p's ou 3b's na coluna
find_3pecas(L, J):-
  member((p(X,Y), J), L), X1 is X+1, X2 is X+2,X3 is X+3,member((p(X1,Y),J), L),
  member((p(X2,Y),J), L), member((p(X3,Y),J1), L),(\+ atomic(J1); \+ J1=J).

%diagonal 1
find_3pecas(L, J):-
  member((p(X,Y), J), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2,X3 is X+3,
  Y3 is Y+3,member((p(X1,Y1),J), L), member((p(X2,Y2),J), L),
  member((p(X3,Y3),J1), L),(\+ atomic(J1); \+ J1=J).

%diagonal 2
find_3pecas(L, J):-
  member((p(X,Y), J), L),
  X1 is X+1, X2 is X+2, Y1 is Y-1, Y2 is Y-2, X3 is X+3, Y3 is Y-3,
  member((p(X1,Y1),J), L), member((p(X2,Y2),J), L),
  member((p(X3,Y3),J1), L),(\+ atomic(J1); \+ J1=J).

% conta o numero total de 4p's ou 4b's
find_all_4pecas(M, J, V):-
  findall((p(X,Y),E), (posicao(X,Y,E,M),atomic(E)), L),
  findall(J, find_4pecas(L, J), L2),length(L2, V).

% encontrar num. de 4p's ou 4b's na linha
find_4pecas(L, J):-
  member((p(X,Y), J), L),
  Y1 is Y+1, Y2 is Y+2, Y3 is Y+3,member((p(X,Y1),J), L),
  member((p(X,Y2),J), L), member((p(X,Y3),J), L).

% encontrar num. de 4p's ou 4b's na coluna
find_4pecas(L, J):-
  member((p(X,Y), J), L),
  X1 is X+1, X2 is X+2,X3 is X+3,member((p(X1,Y),J), L),
  member((p(X2,Y),J), L),member((p(X3,Y),J), L).

%diagonal 1
find_4pecas(L, J):-
  member((p(X,Y), J), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2, X3 is X+3, Y3 is Y+3,
  member((p(X1,Y1),J), L), member((p(X2,Y2),J), L),
  member((p(X3,Y3),J), L).

%diagonal 2
find_4pecas(L, J):-
  member((p(X,Y), J), L),
  X1 is X+1, X2 is X+2, X3 is X+3, Y1 is Y-1, Y2 is Y-2, Y3 is Y-3,
  member((p(X1,Y1),J), L), member((p(X2,Y2),J), L),
  member((p(X3,Y3),J), L).

% avalia(Estado, Avaliacao)
% dados a matriz(M) e a peça(P) que vai jogar, returna em Val o valor da avaliacao
func_aval((Matriz,Peca), Val):-
  find_all_1peca(Matriz, Peca, V1),
  find_all_2pecas(Matriz, Peca, V2),
  find_all_3pecas(Matriz, Peca, V3),
  find_all_4pecas(Matriz, Peca, V7),
  inverteJog(Peca,Peca1),
  find_all_1peca(Matriz, Peca1, V4),
  find_all_2pecas(Matriz, Peca1, V5),
  find_all_3pecas(Matriz, Peca1, V6),
  find_all_4pecas(Matriz, Peca1, V8),
  Val1 is (V1+3*V2+V3+9*V7)-(V4+3*V5+6*V6+9*V8),
  ((V8 >= 1,Val is Val1+1000);(V7 >= 1, Val is Val1+800);Val is Val1) .

inverteJog(b,p).
inverteJog(p,b).
