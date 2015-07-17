%% inicializar(?Num_linhas, ?Num_colunas, ?Matriz)
%
%inicializacao do tabuleiro
inicializar(Nlinhas, Ncolunas, Matriz) :-
  length(Matriz, Nlinhas),  % cria uma lista de aridade N
  maplist(cria_linha(Ncolunas),Matriz). % cria lista para cada posicao da matriz

%%cria_linha(+Ncolunas,?Lista)
%
% cria uma lista com N elementos não instanciados
cria_linha(Ncolunas, L) :-
  length(L, Ncolunas).

%% posicao(+Linha,+Coluna,?Elemento,+Matriz)
%
/* instancia a variável na posição(X,Y) com um elemento E, ou, caso lá esteja um
  elemento atómico, devolve o elemento E que se encontra nessa posição, sendo
  X a linha e Y a coluna */
posicao(X,Y,E,Matriz):-
	nth1(X,Matriz,LinhaX),
  nth1(Y,LinhaX,E).

%% insere(+Peca,+Coluna,+Matriz, ?Coords)
%
/* faz um findall de todos os valores não atómicos da coluna pretendida para uma
  lista e o tamanho dessa lista irá ser a linha exacta onde instanciar com a
  peca a inserir. Caso já todos os elementos dessa coluna estejam instanciados,
  ou seja, caso sejam todos atómicos, o predicado falha.*/
insere(Peca,Coluna,Matriz,p(Linha,Coluna,Peca)):-
	findall(E,(posicao(_,Coluna,E,Matriz), \+ atomic(E)),L), length(L,Linha),
  \+ all_atomic(L),posicao(Linha,Coluna,Peca,Matriz).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% print_tabuleiro(+Matriz)
%
%faz um print do tabuleiro
print_tabuleiro(T):-
  nl,print_linhas(T),nl.

%% print_linhas(+Matriz)
%
/* para cada linha da matriz imprime todos os elementos dessa linha e passa à
   proxima até chegar ao fim da matriz*/
print_linhas([]).
print_linhas([L|Ls]) :-
  write('      | '),print_elementos(L),nl,nl, print_linhas(Ls).

%% print_elementos(+Lista)
%
% imprime todos os elementos de uma linha
print_elementos([]).
print_elementos([E|Es]):-
  ( (\+ atomic(E), write('-'));(atomic(E), write(E)) ),
  write(' | '), print_elementos(Es).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% inicia o jogo chamando o loop do menu principal
go:-
  menu.

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

%% menuOpt(+Opcao)
%
% caso de escolha da opção 1 (Humano vs humano)
menuOpt(1):-
	write('\n\nInsira as dimensões N e M (NxM):\n\n'),
      write('N (>=4)? \n'), read(Nlinhas), write(Nlinhas),
  write('\n\nM (>=4)? \n'), read(Ncolunas), write(Ncolunas), nl,
  ((integer(Nlinhas),integer(Ncolunas), Nlinhas > 3,Ncolunas > 3,
     inicializar(Nlinhas,Ncolunas,Matriz), ciclo(1,Matriz,p(1,1),hvsh)
    );menuOpt(1)
  ).

%caso de escolha da opção 2 (Humano vs AI)
menuOpt(2):-
	write('\n\nInsira as dimensões N e M (NxM):\n\n'),
      write('N (>=4)? \n'), read(Nlinhas), write(Nlinhas),
  write('\n\nM (>=4)? \n'), read(Ncolunas), write(Ncolunas), nl,
  ((integer(Nlinhas), integer(Ncolunas),Nlinhas > 3,Ncolunas > 3,
     subMenu(Nlinhas,Ncolunas));menuOpt(2)).

%saida do menu
menuOpt(0):-!.

%casos em que não é inserido nenhum dos números desejados
menuOpt(_):-
	nl, menu.

%% submenu(+NumLinhas,+NumColunas)
%
%submenu do modo humano vs AI - input primeiro a jogar
subMenu(N,M):-
  write('\nJogador inicial:\n'),
    write('     1 - Humano\n'),
    write('     2 - AI\n\n'),
    write('Insira o número correspondente à opção:\n'), read(J),write(J),nl,
  (integer(J),between(1,2,J), inicializar(N,M,Matriz),ciclo(J,Matriz,p(1,1),hvsc));
   (subMenu(N,M)).

%% player(?Jogador,?Peca,?StringJog,?Modo)
%
% predicado para controlar o que escrever como output de acordo com o jogador
% e saber qual a peca de cada jogador ou qual o jogador que usa determinada peca
player(1,p,'Jogador 1',_).
player(2,v,'Jogador 2',hvsh).
player(2,v,'AI',hvsc).

% ciclos modo humano vs humano e humano vs AI. Jogador 1 é sempre as peças
% pretas e o jogador 2 e AI são sempre as peças vermelhas

%% ciclo(+Jogador, +Matriz,+UltPecaJogada, +ModoJogo)
%
% primeira coisa no ciclo é verificar o terminal do jogo (se alguém ganhou)
ciclo(_,Matriz,UltPecaJog,Modo):-
    verifica_terminal(Matriz,UltPecaJog,Ganhou), !, print_tabuleiro(Matriz),
    write('O vencedor é: '), player(Ganhou,_,J,Modo),write(J).

/* caso não haja condições de vitória a 2a verificação a fazer é se a última
  linha do tabuleiro se encontra preenchida, caso esteja é necessário
  eliminá-la e descer as restantes linhas para baixo*/
ciclo(Jogador,Matriz,UltPecaJog,Modo):-
  check_lastLine(Matriz), desce_tabuleiro(Matriz,NovaMatriz),
  ciclo(Jogador,NovaMatriz,UltPecaJog,Modo).

% jogador 1 a jogar, caso a inserção falhe é pedido input novamente ao jogador 1
ciclo(1,Matriz,UltPecaJog,Modo):-
  print_tabuleiro(Matriz),
  write('Jogador 1 insira a coluna onde jogar: \n'),
  read(Coluna), write(Coluna), nl,
  (insere(p,Coluna,Matriz,UltPecaJog1),ciclo(2,Matriz,UltPecaJog1,Modo));
   ciclo(1,Matriz,UltPecaJog,Modo).

/* jogador 2 a jogar (modo humano vs humano), caso a inserção falhe é pedido
  input novamente ao jogador 2*/
ciclo(2,Matriz,UltPecaJog,hvsh):-
  print_tabuleiro(Matriz),
  write('Jogador 2 insira a coluna onde jogar: \n'),
  read(Coluna), write(Coluna),nl,
  (insere(v,Coluna,Matriz,UltPecaJog2),ciclo(1,Matriz,UltPecaJog2,Modo));
   ciclo(2,Matriz,UltPecaJog,Modo).

/* jogador 2 (AI) a jogar (modo humano vs AI). São encontrados todos os pares
  Valor-Coluna cujo valor é determinado usando uma função de avaliação (heurística),
  e é seleccionado o par com o maior valor da lista resultante sendo o segundo
  valor do par a coluna onde a peça irá ser jogada pela AI*/
ciclo(2,Matriz,_,hvsc):-
   print_tabuleiro(Matriz), write('AI a calcular jogada... \n'),
   nth1(1,Matriz,Linha), length(Linha, Ncolunas),
   geraNumsI_J(1,Ncolunas,Colunas),
   findall(Valor-Coluna, simula_jogs(Matriz,Colunas,Valor, Coluna), Lista ),
   length(Lista,Size), % caso a lista esteja vazia joga numa coluna qualquer
   ( (Size \= 0, max_member(_-Coluna,Lista) );
   member(Coluna,Colunas) ),
   insere(v,Coluna,Matriz,UltPecaJog),
   write('\nAI a jogar na coluna: '), write(Coluna),nl,
   ciclo(1,Matriz,UltPecaJog,hvsc).

%% simula_jogs(+Matriz,+Lista_Colunas, ?Valor, ?Coluna)
%
% Simula a jogada do AI e a jogada do jogador a seguir, prevendo 2 jogadas à
% frente, e determina qual o valor associado à coluna onde pretende jogar
simula_jogs(Matriz,Colunas,Valor,Coluna):-
  member(Coluna1,Colunas),
  ((insere(v,Coluna1,Matriz,_));(fail)),
  func_aval((Matriz,v),Valor1),
  ((check_lastLine(Matriz),desce_tabuleiro(Matriz,Matriz2));
   (Matriz2 = Matriz)),
  member(Coluna2,Colunas),
  ((insere(p,Coluna2,Matriz,_));(fail)),
  func_aval((Matriz2,p),Valor2),
  ((Valor1 > Valor2, Valor = Valor1, Coluna = Coluna1);
  (Valor2 > Valor1, Valor = Valor2, Coluna1\==Coluna2, Coluna = Coluna2);
  (Valor is Valor1-Valor2, Coluna1\==Coluna2, Coluna is Coluna1)).

%% geraNumsI_J(+Min, +Max, ?Lista)
%
% gera uma lista com todos os numeros de I a J (inclusivé)
geraNumsI_J(I,J,L):-
  findall(N, between(I,J,N), L).

%% check_lastLine(+Matriz,?Nlinhas)
%
% Verifica se todos os elementos da ultima linha estão instanciados
% (todos atómicos)
check_lastLine(Matriz):-
  length(Matriz,Nlinhas),
  nth1(Nlinhas,Matriz,UltimaLinha),
  all_atomic(UltimaLinha).

%% all_atomic(+Lista)
%
% verifica se todos os elementos de uma lista são atómicos usando o predicado
% maplist que sucede se o goal for aplicável a todos os elementos da lista
all_atomic(Lista):-
  maplist(atomic, Lista).

%% desce_tabuleiro(+Matriz,+Numlinhas,?NovaMatriz)
%
%remove a ultima linha e cria uma nova linha no inicio da matriz
desce_tabuleiro(Matriz,Matriz3):-
  length(Matriz,Nlinhas),
  nth1(Nlinhas,Matriz,UltimaLinha,Matriz2), % remove a ultima linha
  length(UltimaLinha,N1), cria_linha(N1,NovaLinha), % cria uma nova linha
  nth1(1,Matriz3,NovaLinha,Matriz2).% adiciona a nova linha no inicio da matriz

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ver_pecas(+Lista, +NumPecasPretas, +NumPecasVermelhas, ?QuemGanhou)
%
% conta o número de peças vermelhas ou peças pretas numa lista e guarda quem
% ganhou se algum dos jogadores tiver 4 peças seguidas, caso chegue ao fim da
% lista e nao haja 4 pecas seguidas, o predicado falha
ver_pecas(_,4,_,1).
ver_pecas(_,_,4,2).
ver_pecas([],Np,Nv,0):- Np < 4, Nv < 4, fail.

ver_pecas([E|Es],_,_,G):- \+ atomic(E),ver_pecas(Es,0,0,G).

ver_pecas([E|Es],Np,Nv,G):-
  atomic(E), (E == p, Np1 is Np + 1,ver_pecas(Es,Np1,0,G));
             (E == v, Nv1 is Nv + 1,ver_pecas(Es,0,Nv1,G)).

%% verifica_terminal(+Matriz,+UltPecaJogada,?QuemGanhou)
%
/* verifica a linha e coluna onde a ultima peca foi jogada e verifica as
  diagonais no tabuleiro. Recebe como arg o tabuleiro e a ultima peca que foi
  jogada e as suas coordenadas (p(Linha,Coluna,Peca)). O predicado falha se
  nenhum dos jogadores estiver em condições de vitória */
verifica_terminal(Matriz,UltPecaJog,Ganhou):-
	verifica_linha(Matriz,UltPecaJog,Ganhou);
  verifica_coluna(Matriz,UltPecaJog,Ganhou);
  verifica_diagonais(Matriz,UltPecaJog,Ganhou).

%% verifica_linha(+Matriz, +UltPecaJogada, ?QuemGanhou)
%
% verifica a linha onde a peca foi inserida
verifica_linha(Matriz,p(X,_,_),Ganhou):-
  (nth1(X,Matriz,Linha), ver_pecas(Linha,0,0,Ganhou)).

%% verifica_coluna(+Matriz, +UltPecaJogada, ?QuemGanhou)
%
% verifica a coluna onde a peca foi inserida
verifica_coluna(Matriz,p(_,Y,_),Ganhou):-
  (findall(E, posicao(_,Y,E,Matriz),Coluna),ver_pecas(Coluna,0,0,Ganhou)).

%% verifica_diagonais(+Matriz, +UltPecaJogada, ?QuemGanhou)
%
/* verifica se há diagonais com 4 pecas seguidas*/
verifica_diagonais(Matriz, p(_,_,Peca),Ganhou):-
  check_diags(Matriz,Peca), player(Ganhou,Peca,_,_).

%% check_diags(+Matriz,+Peca)
%
% tenta enontrar uma diagonal com 4 pecas seguidas, caso haja alguma significa
% que um dos jogadores ganhou
check_diags(Matriz,Peca):-
  findall(p(X,Y,E), (posicao(X,Y,E,Matriz),atomic(E)), L),
  encontra_diag(L,Peca).

%% encontra_diag(+Lista, +Peca)
%
% procura diagonal do canto superior esquerdo para o canto
% inferior direito que tenha 4 pecas seguidas
encontra_diag(L,Peca):-
  member(p(X,Y,Peca), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2, X3 is X+3, Y3 is Y+3,
  member(p(X1,Y1,Peca), L), member(p(X2,Y2,Peca), L),
  member(p(X3,Y3,Peca), L).

%% encontra_diag(+Lista, +Peca)
%
% encontra diagonal do canto superior direito para o canto
% inferior esquerdo que tenha 4 pecas seguidas
encontra_diag(L,Peca):-
  member(p(X,Y,Peca), L),
  X1 is X+1, X2 is X+2, X3 is X+3, Y1 is Y-1, Y2 is Y-2, Y3 is Y-3,
  member(p(X1,Y1,Peca), L), member(p(X2,Y2,Peca), L),
  member(p(X3,Y3,Peca), L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% heuristica

%% find_all_1peca(+Lista, +Peca, ?Num1peca)
%
% conta o numero total de 1p's ou 1v's
find_all_1peca(L, Peca, N):-
  findall(Peca, find_1peca(L, Peca), L2),length(L2, N).

%% find_1peca(+Lista, +Peca)
%
% encontrar 1p's ou 1v's
find_1peca(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X+1, X2 is X-1,Y1 is Y-1, Y2 is Y+1,
  \+ member(p(X,Y1,Peca), L), \+ member(p(X,Y2,Peca), L),
  \+ member(p(X1,Y,Peca), L), \+ member(p(X2,Y,Peca), L),
  \+ member(p(X1,Y1,Peca), L), \+ member(p(X2,Y2,Peca), L),
  \+ member(p(X1,Y2,Peca), L), \+ member(p(X2,Y1,Peca), L).

%% find_all_2pecas(+Lista, +Peca, ?Num2pecas)
%
% conta o numero total de 2p's ou 2v's
find_all_2pecas(L, Peca, N):-
  findall(Peca, find_2pecas(L, Peca), L2),length(L2, N).

%% find_2pecas(+Lista, +Peca)
%
% encontrar 2p's ou 2v's na linha
find_2pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  Y1 is Y-1,Y2 is Y-2,
  member(p(X,Y1,Peca), L), member(p(X,Y2,Peca1), L),
  \+ atomic(Peca1).

% encontrar 2p's ou 2v's na coluna
find_2pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X-1, X2 is X-2,
  member(p(X1,Y,Peca), L), member(p(X2,Y,Peca1), L),
  \+ atomic(Peca1).

%diagonal 1
find_2pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X-1, Y1 is Y-1,X2 is X-2, Y2 is Y-2,
  member(p(X1,Y1,Peca), L), member(p(X2,Y2,Peca1), L),
  \+ atomic(Peca1).

%diagonal 2
find_2pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X-1, Y1 is Y+1,X2 is X-2,Y2 is Y-2,
  member(p(X1,Y1,Peca), L), member(p(X2,Y2,Peca1), L),
  \+ atomic(Peca1).

%% find_all_3pecas(+Lista, +Peca, ?Num3pecas)
%
% conta o numero total de 3p's ou 3v's
find_all_3pecas(L, Peca, N):-
  findall(Peca, find_3pecas(L, Peca), L2),length(L2, N).

%% find_3pecas(+Lista, +Peca)
%
% encontrar 3p's ou 3v's na linha
find_3pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  Y1 is Y+1, Y2 is Y+2, Y3 is Y+3, member(p(X,Y1,Peca), L),
  member(p(X,Y2,Peca), L), member(p(X,Y3,Peca1), L),
  \+ atomic(Peca1).

% encontrar 3p's ou 3v's na coluna
find_3pecas(L, Peca):-
  member(p(X,Y,Peca), L), X1 is X+1, X2 is X+2,X3 is X+3,
  member(p(X1,Y,Peca), L),member(p(X2,Y,Peca), L),member(p(X3,Y,Peca1), L),
  \+ atomic(Peca1).

%diagonal 1
find_3pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2,X3 is X+3, Y3 is Y+3,
  member(p(X1,Y1,Peca), L), member(p(X2,Y2,Peca), L),
  member(p(X3,Y3,Peca1), L),\+ atomic(Peca1).

%diagonal 2
find_3pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X+1, X2 is X+2, Y1 is Y-1, Y2 is Y-2, X3 is X+3, Y3 is Y-3,
  member(p(X1,Y1,Peca), L), member(p(X2,Y2,Peca), L),
  member(p(X3,Y3,Peca1), L),\+ atomic(Peca1).

%% find_all_4pecas(+Lista, +Peca, ?Num4pecas)
%
% conta o numero total de 4p's ou 4v's
find_all_4pecas(L, Peca, N):-
  findall(Peca, find_4pecas(L, Peca), L2),length(L2, N).

%% find_4pecas(+Lista, +Peca)
%
% encontrar 4p's ou 4v's na linha
find_4pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  Y1 is Y+1, Y2 is Y+2, Y3 is Y+3,
  member(p(X,Y1,Peca), L),
  member(p(X,Y2,Peca), L),
  member(p(X,Y3,Peca), L).

% encontrar 4p's ou 4v's na coluna
find_4pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X+1, X2 is X+2,X3 is X+3,
  member(p(X1,Y,Peca), L), member(p(X2,Y,Peca), L),
  member(p(X3,Y,Peca), L).

%diagonal 1
find_4pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2, X3 is X+3, Y3 is Y+3,
  member(p(X1,Y1,Peca), L), member(p(X2,Y2,Peca), L),
  member(p(X3,Y3,Peca), L).

%diagonal 2
find_4pecas(L, Peca):-
  member(p(X,Y,Peca), L),
  X1 is X+1, X2 is X+2, X3 is X+3, Y1 is Y-1, Y2 is Y-2, Y3 is Y-3,
  member(p(X1,Y1,Peca), L), member(p(X2,Y2,Peca), L),
  member(p(X3,Y3,Peca), L).

%% func_aval(+Tuplo_MatrizPeca,+ValorAvaliacao)
%
% dados a matriz(M) e a peça(P) que vai jogar, returna em Val o valor da avaliacao
func_aval((Matriz,Peca), Val):-
  %encontra todos os elementos atómicos e as suas coordenadas
  findall(p(X,Y,E), (posicao(X,Y,E,Matriz),atomic(E)), L),
  find_all_1peca(L, Peca, V1),
  find_all_2pecas(L, Peca, V2),
  find_all_3pecas(L, Peca, V3),
  find_all_4pecas(L, Peca, V7),
  invertePeca(Peca,Peca1),
  find_all_1peca(L, Peca1, V4),
  find_all_2pecas(L, Peca1, V5),
  find_all_3pecas(L, Peca1, V6),
  find_all_4pecas(L, Peca1, V8),
  Val1 is (V1+3*V2+6*V3+9*V7)-(V4+3*V5+6*V6+9*V8),
  ((V7 >= 1,Val is Val1+1000); Val = Val1).

%% invertePeca(?Peca1,?Peca2)
%
% inverte as pecas de um jogador para as do outro
invertePeca(v,p).
invertePeca(p,v).
