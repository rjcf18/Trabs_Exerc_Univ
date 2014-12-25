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
insere(Peca,Coluna,(Matriz,p(Linha,Coluna))):-
	findall(E,(posicao(_,Coluna,E,Matriz), \+ atomic(E)),L), length(L,Linha),
  (\+ all_atomic(L),posicao(Linha,Coluna,Peca,Matriz));(fail).

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
     inicializar(Nlinhas,Ncolunas,Matriz), ciclo(1,(Matriz,p(1,1)),hvsh)
    );menuOpt(1)
  ).

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
  (integer(J),between(1,2,J), inicializar(N,M,Matriz),ciclo(J,(Matriz,p(1,1)),hvsc));
   (subMenu(N,M)).

/* predicado para controlar qual o jogador 1 e jogador 2 durante o ciclo */
player(1,'Jogador 1',_).
player(2,'Jogador 2',hvsh).
player(2,'AI',hvsc).


/* ciclos modo humano vs humano e humano vs AI. Jogador 1 é sempre as peças pretas
  e o jogador 2 e AI são sempre as peças vermelhas */

% primeira coisa no ciclo é verificar o terminal do jogo (se alguém ganhou)
ciclo(_,(Matriz,UltPecaJog),Modo):-
  verifica_terminal(Matriz,UltPecaJog), !, print_tabuleiro(Matriz),
  write('O vencedor é: '), ganhou(X), player(X,J,Modo),write(J).

/* caso não haja condições de vitória a 2a verificação a fazer é se a última
  linha do tabuleiro se encontra preenchida, caso esteja é necessário
  eliminá-la e descer as restantes linhas para baixo*/
ciclo(Jogador,(Matriz,UltPecaJog),Modo):-
  length(Matriz,Nlinhas),nth1(Nlinhas,Matriz,UltimaLinha),
  all_atomic(UltimaLinha), desce_tabuleiro(Matriz,Nlinhas,NovaMatriz),
  ciclo(Jogador,(NovaMatriz,UltPecaJog),Modo).

% jogador 1 a jogar, caso a inserção falhe é pedido input novamente ao jogador 1
ciclo(1,(Matriz,UltPecaJog),Modo):-
  print_tabuleiro(Matriz),
  write('Jogador 1 insira a coluna onde jogar: \n'),
  read(Coluna), write(Coluna), nl,
  (insere(p,Coluna,(Matriz,UltPecaJog1)),ciclo(2,(Matriz,UltPecaJog1),Modo));
   ciclo(1,(Matriz,UltPecaJog),Modo).

/* jogador 2 a jogar (modo humano vs humano), caso a inserção falhe é pedido
  input novamente ao jogador 2*/
ciclo(2,(Matriz,UltPecaJog),hvsh):-
  print_tabuleiro(Matriz),
  write('Jogador 2 insira a coluna onde jogar: \n'),
  read(Coluna), write(Coluna),nl,
  (insere(v,Coluna,(Matriz,UltPecaJog2)),ciclo(1,(Matriz,UltPecaJog2),Modo));
   ciclo(2,(Matriz,UltPecaJog),Modo).

/* jogador 2 (AI) a jogar (modo humano vs AI). São encontrados todos os pares
  Valor-Coluna cujo valor é determinado usando uma função de avaliação (heurística),
  e é seleccionado o par com o maior valor da lista resultante sendo o segundo
  valor do par a coluna onde a peça irá ser jogada pela AI*/
ciclo(2,(Matriz,_),hvsc):-
  print_tabuleiro(Matriz),
  write('AI a calcular jogada... \n'),
  nth1(1,Matriz,Linha),
  length(Linha, Ncolunas),
  geraNumsI_J(1,Ncolunas,Colunas),
  findall(Valor-Coluna2, ( member(Coluna1,Colunas),insere(v,Coluna1,(Matriz,_)),
                          func_aval((Matriz,v),Valor1),
                          member(Coluna2,Colunas),insere(p,Coluna2,(Matriz,_)),
                          func_aval((Matriz,v),Valor2),Valor is Valor1+Valor2
                        ), Lista ),
  max_member(_-Coluna,Lista),
  insere(v,Coluna,(Matriz,UltPecaJog)),
  write('\nAI a jogar na coluna: '),
  write(Coluna),nl,
  ciclo(1,(Matriz,UltPecaJog),hvsc).

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
  append([NovaLinha],Matriz2,Matriz3).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%guarda quem ganhou o jogo
guarda(ganhou(P)):- retractall(ganhou(_)), asserta(ganhou(P)).

% conta o número de peças vermelhas ou peças pretas numa lista e guarda quem
% ganhou se algum dos jogadores tiver 4 peças seguidas, caso chegue ao fim da
% lista e nao haja 4 pecas seguidas, o predicado falha
ver_pecas(_,4,_):- guarda(ganhou(1)),!.
ver_pecas(_,_,4):- guarda(ganhou(2)),!.
ver_pecas([],Np,Nv):- Np < 4, Nv < 4, fail.

ver_pecas([E|Es],_,_):- \+ atomic(E),ver_pecas(Es,0,0).

ver_pecas([E|Es],Np,Nv):-
  atomic(E), (E == p, Np1 is Np + 1,ver_pecas(Es,Np1,0));
             (E == v, Nv1 is Nv + 1,ver_pecas(Es,0,Nv1)).

/* verifica a linha e coluna onde a ultima peca foi jogada e verifica as
  diagonais no tabuleiro. Recebe como arg o tabuleiro e as coordenadas onde a
  ultima peca foi jogada (p(X,Y)). O predicado falha se nenhum dos jogadores
  estiver em condições de vitória */
verifica_terminal(Matriz,UltPecaJog):-
	verifica_linha(Matriz,UltPecaJog);
  verifica_coluna(Matriz,UltPecaJog);
  verifica_diagonais(Matriz).

% verifica a linha onde a peca foi inserida
verifica_linha(Matriz,p(X,_)):-
  (nth1(X,Matriz,Linha), ver_pecas(Linha,0,0)).

% verifica a coluna onde a peca foi inserida
verifica_coluna(Matriz,p(_,Y)):-
  (findall(E, posicao(_,Y,E,Matriz),L),ver_pecas(L,0,0)).

/* verifica se há diagonais com 4 pecas seguidas*/
verifica_diagonais(Matriz):-
  (check_diags(Matriz,p),guarda(ganhou(1)));
  (check_diags(Matriz,v),guarda(ganhou(2))).

% procura todas as diagonais com 4 pecas seguidas e caso haja 1 ou mais,
% significa que um dos jogadores ganhou
check_diags(Matriz,Peca):-
  findall((p(X,Y),E), (posicao(X,Y,E,Matriz),atomic(E)), L),
  findall(Peca, encontra(L,Peca), L2),length(L2, V), V > 0.

% procura diagonal do canto inferior esquerdo para o canto
% superior direito que tenha 4 pecas seguidas
encontra(L,Peca):-
  member((p(X,Y), Peca), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2, X3 is X+3, Y3 is Y+3,
  member((p(X1,Y1),Peca), L), member((p(X2,Y2),Peca), L), member((p(X3,Y3),Peca), L).

% encontra diagonal do canto superior esquerdo para o canto
% inferior direito que tenha 4 pecas seguidas
encontra(L,Peca):-
  member((p(X,Y), Peca), L),
  X1 is X+1, X2 is X+2, X3 is X+3, Y1 is Y-1, Y2 is Y-2, Y3 is Y-3,
  member((p(X1,Y1),Peca), L), member((p(X2,Y2),Peca), L), member((p(X3,Y3),Peca), L).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% conta o numero total de 1p's ou 1v's
find_all_1peca(Matriz, Peca, N):-
  %encontra todos os membros atomicos do estado
  findall((p(X,Y),E), (posicao(X,Y,E,Matriz),atomic(E)), L),
  findall(Peca, find_1peca(L, Peca), L2),length(L2, N).

% encontrar 1p's ou 1v's
find_1peca(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X+1, X2 is X-1,Y1 is Y-1, Y2 is Y+1,
  \+ member((p(X,Y1),Peca), L), \+ member((p(X,Y2),Peca), L),
  \+ member((p(X1,Y),Peca), L), \+ member((p(X2,Y),Peca), L),
  \+ member((p(X1,Y1),Peca), L), \+ member((p(X2,Y2),Peca), L),
  \+ member((p(X1,Y2),Peca), L), \+ member((p(X2,Y1),Peca), L).

% conta o numero total de 2p's ou 2v's
find_all_2pecas(Matriz, Peca, N):-
  findall((p(X,Y),E), (posicao(X,Y,E,Matriz),atomic(E)), L),
  findall(Peca, find_2pecas(L, Peca), L2),length(L2, N).

% encontrar 2p's ou 2v's na linha
find_2pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  Y1 is Y-1,Y2 is Y-2,
  member((p(X,Y1),Peca), L), member((p(X,Y2),Peca), L),
  (\+ atomic(Peca1); \+ Peca1=Peca).

% encontrar 2p's ou 2v's na coluna
find_2pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X-1, X2 is X-2,
  member((p(X1,Y),Peca), L), member((p(X2,Y),Peca1), L),
  (\+ atomic(Peca1); \+ Peca1=Peca).

%diagonal 1
find_2pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X-1, Y1 is Y-1,X2 is X-2, Y2 is Y-2,
  member((p(X1,Y1),Peca), L), member((p(X2,Y2),Peca1), L),
  (\+ atomic(Peca1); \+ Peca1=Peca).

%diagonal 2
find_2pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X-1, Y1 is Y+1,X2 is X-2,Y2 is Y-2,
  member((p(X1,Y1),Peca), L), member((p(X2,Y2),Peca1), L),
  (\+ atomic(Peca1); \+ Peca1=Peca).

% conta o numero total de 3p's ou 3v's
find_all_3pecas(Matriz, Peca, N):-
  findall((p(X,Y),E), (posicao(X,Y,E,Matriz),atomic(E)), L),
  findall(Peca, find_3pecas(L, Peca), L2),length(L2, N).

% encontrar 3p's ou 3v's na linha
find_3pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  Y1 is Y+1, Y2 is Y+2, Y3 is Y+3, member((p(X,Y1),Peca), L),
  member((p(X,Y2),Peca), L), member((p(X,Y3),Peca1), L),
  (\+ atomic(Peca1); \+ Peca1=Peca).

% encontrar 3p's ou 3v's na coluna
find_3pecas(L, Peca):-
  member((p(X,Y), Peca), L), X1 is X+1, X2 is X+2,X3 is X+3,
  member((p(X1,Y),Peca), L),member((p(X2,Y),Peca), L),member((p(X3,Y),Peca1), L),
  (\+ atomic(Peca1); \+ Peca1=Peca).

%diagonal 1
find_3pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2,X3 is X+3, Y3 is Y+3,
  member((p(X1,Y1),Peca), L), member((p(X2,Y2),Peca), L),
  member((p(X3,Y3),Peca1), L),(\+ atomic(Peca1); \+ Peca1=Peca).

%diagonal 2
find_3pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X+1, X2 is X+2, Y1 is Y-1, Y2 is Y-2, X3 is X+3, Y3 is Y-3,
  member((p(X1,Y1),Peca), L), member((p(X2,Y2),Peca), L),
  member((p(X3,Y3),Peca1), L),(\+ atomic(Peca1); \+ Peca1=Peca).

% conta o numero total de 4p's ou 4v's
find_all_4pecas(Matriz, Peca, N):-
  findall((p(X,Y),E), (posicao(X,Y,E,Matriz),atomic(E)), L),
  findall(Peca, find_4pecas(L, Peca), L2),length(L2, N).

% encontrar 4p's ou 4v's na linha
find_4pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  Y1 is Y+1, Y2 is Y+2, Y3 is Y+3,
  member((p(X,Y1),Peca), L),
  member((p(X,Y2),Peca), L),
  member((p(X,Y3),Peca), L).

% encontrar 4p's ou 4v's na coluna
find_4pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X+1, X2 is X+2,X3 is X+3,
  member((p(X1,Y),Peca), L), member((p(X2,Y),Peca), L),
  member((p(X3,Y),Peca), L).

%diagonal 1
find_4pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2, X3 is X+3, Y3 is Y+3,
  member((p(X1,Y1),Peca), L), member((p(X2,Y2),Peca), L),
  member((p(X3,Y3),Peca), L).

%diagonal 2
find_4pecas(L, Peca):-
  member((p(X,Y), Peca), L),
  X1 is X+1, X2 is X+2, X3 is X+3, Y1 is Y-1, Y2 is Y-2, Y3 is Y-3,
  member((p(X1,Y1),Peca), L), member((p(X2,Y2),Peca), L),
  member((p(X3,Y3),Peca), L).

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

inverteJog(v,p).
inverteJog(p,v).
