:-dynamic(ganhador/1).

%(lista com pos., ultima peca jogada)
estado_inicial(([(p(1,1), _),(p(1,2), _),(p(1,3), _),(p(1,4), _),(p(1,5), _),(p(1,6), _),(p(1,7), _),
                 (p(2,1), _),(p(2,2), _),(p(2,3), _),(p(2,4), _),(p(2,5), _),(p(2,6), _),(p(2,7), _),
                 (p(3,1), _),(p(3,2), _),(p(3,3), _),(p(3,4), _),(p(3,5), _),(p(3,6), _),(p(3,7), _),
                 (p(4,1), _),(p(4,2), _),(p(4,3), _),(p(4,4), _),(p(4,5), _),(p(4,6), _),(p(4,7), _),
                 (p(5,1), _),(p(5,2), _),(p(5,3), _),(p(5,4), _),(p(5,5), _),(p(5,6), _),(p(5,7), _),
                 (p(6,1), _),(p(6,2), _),(p(6,3), _),(p(6,4), _),(p(6,5), _),(p(6,6), _),(p(6,7), _)], _)).

valor((E, _), 100, _):-(linhas(E);colunas(E);diagonais(E)),ganhador(o),!.
valor((E, _), -100, _):-(linhas(E);colunas(E);diagonais(E)),ganhador(x),!.
valor((E, _), 0, _):- empate(E),!.


terminal((E,_)):-
	linhas(E);colunas(E);diagonais(E);empate(E).

linhas(E):-
	(findall(X1,member((p(1, _), X1),E), L1),check(L1, 0, 0));
	(findall(X2,member((p(2, _), X2),E), L2),check(L2, 0, 0));
	(findall(X3,member((p(3, _), X3),E), L3),check(L3, 0, 0));
	(findall(X4,member((p(4, _), X4),E), L4),check(L4, 0, 0));
	(findall(X5,member((p(5, _), X5),E), L5),check(L5, 0, 0));
	(findall(X6,member((p(6, _), X6),E), L6),check(L6, 0, 0)).

colunas(E):-
	(findall(X1,member((p(_, 1), X1),E), C1),check(C1, 0, 0));
	(findall(X2,member((p(_, 2), X2),E), C2),check(C2, 0, 0));
	(findall(X3,member((p(_, 3), X3),E), C3),check(C3, 0, 0));
	(findall(X4,member((p(_, 4), X4),E), C4),check(C4, 0, 0));
	(findall(X5,member((p(_, 5), X5),E), C5),check(C5, 0, 0));
	(findall(X6,member((p(_, 6), X6),E), C6),check(C6, 0, 0)).

diagonais(E):-
	diagonais_1(E);diagonais_2(E).

diagonais_1(E):-
	(findall(J1, (member((p(X1,Y1), J1), E), (diagonal_left_half_1(4, 1, LP1), member((X1, Y1), LP1))), D1),check(D1, 0, 0));
	(findall(J2, (member((p(X2,Y2), J2), E), (diagonal_left_half_1(5, 1, LP2), member((X2, Y2), LP2))), D2),check(D2, 0, 0));
	(findall(J3, (member((p(X3,Y3), J3), E), (diagonal_left_half_1(6, 1, LP3), member((X3, Y3), LP3))), D3),check(D3, 0, 0));
	(findall(J4, (member((p(X4,Y4), J4), E), (diagonal_right_half_1(6, 2, LP4), member((X4, Y4), LP4))), D4),check(D4, 0, 0));
	(findall(J5, (member((p(X5,Y5), J5), E), (diagonal_right_half_1(6, 3, LP5), member((X5, Y5), LP5))), D5),check(D5, 0, 0));
	(findall(J6, (member((p(X6,Y6), J6), E), (diagonal_right_half_1(6, 4, LP6), member((X6, Y6), LP6))), D6),check(D6, 0, 0)).

diagonais_2(E):-
	(findall(J1, (member((p(X1,Y1), J1), E), (diagonal_right_half_2(4, 7, LP1), member((X1, Y1), LP1))), D1),check(D1, 0, 0));
	(findall(J2, (member((p(X2,Y2), J2), E), (diagonal_right_half_2(5, 7, LP2), member((X2, Y2), LP2))), D2),check(D2, 0, 0));
	(findall(J3, (member((p(X3,Y3), J3), E), (diagonal_right_half_2(6, 7, LP3), member((X3, Y3), LP3))), D3),check(D3, 0, 0));
	(findall(J4, (member((p(X4,Y4), J4), E), (diagonal_right_half_2(6, 6, LP4), member((X4, Y4), LP4))), D4),check(D4, 0, 0));
	(findall(J5, (member((p(X5,Y5), J5), E), (diagonal_left_half_2(6, 5, LP5), member((X5, Y5), LP5))), D5),check(D5, 0, 0));
	(findall(J6, (member((p(X6,Y6), J6), E), (diagonal_left_half_2(6, 4, LP6), member((X6, Y6), LP6))), D6),check(D6, 0, 0)).

% -------------------------------------- FUNCOES AUXILIARES -----------------------------------------------
guarda(ganhador(P)):- retractall(ganhador(_)), asserta(ganhador(P)),!.

check( _, 4, _):-guarda(ganhador(x)),!.
check( _, _, 4):-guarda(ganhador(o)),!.
check( [], NX, NO):- NX < 4, NO < 4,fail.
check([H|T], NX, NO):-
	count_(H, NX, NO, NX2, NO2),
	check(T, NX2, NO2).

% count_(?ElementoDaPosicao, ?Jogador, ?NumXAntesIncrem, ?NumOAntesIncrem, ?NumXDepoisIncrem, ?NumXDepoisIncrem)
count_(E, NX, _, NX2, 0):-
	nonvar(E), E = x,
	NX2 is NX+1.
count_(E, _, NO, 0, NO2):-
	nonvar(E), E = o,
	NO2 is NO+1.
count_(E, _, _, 0, 0):- var(E).


% ---------------------------------DIAGONAIS - ESQUERDA PARA DIREITA---------------------------------------
diagonal_left_half_1(X, Y, [(X, Y)|T]):-
	X2 is X-1, Y2 is Y+1,
	diagonal_left_half_1(X2, Y2, Y, X, T).
diagonal_left_half_1(X, Y, XLimit, YLimit, [(X, Y)]):-
	X = XLimit.
diagonal_left_half_1(X, Y, XLimit, YLimit, [(X, Y)|T]):-
	X > XLimit,
	X2 is X-1, Y2 is Y+1,
	diagonal_left_half_1(X2, Y2, XLimit, YLimit, T).

diagonal_right_half_1(X, Y, [(X, Y)|T]):-
	X2 is X-1, Y2 is Y+1,
	YLimit is Y-1,
	diagonal_right_half_1(X2, Y2, YLimit, X, T).
diagonal_right_half_1(X, Y, XLimit, YLimit, [(X, Y)]):-
	X = XLimit.
diagonal_right_half_1(X, Y, XLimit, YLimit, [(X, Y)|T]):-
	X > XLimit,
	X2 is X-1, Y2 is Y+1,
	diagonal_right_half_1(X2, Y2, XLimit, YLimit, T).
% ---------------------------------DIAGONAIS - DIREITA PARA ESQUERDA---------------------------------------

diagonal_right_half_2(X, Y, [(X, Y)|T]):-
	X2 is X-1, Y2 is Y-1, Limit is Y-X+1,
	diagonal_right_half_2(X2, Y2, Limit, T).
diagonal_right_half_2(X, Y, Limit, [(X, Y)]):-
	Y = Limit.
diagonal_right_half_2(X, Y, Limit, [(X, Y)|T]):-
	Y > Limit,
	X2 is X-1, Y2 is Y-1,
	diagonal_right_half_2(X2, Y2, Limit, T).

diagonal_left_half_2(X, Y, [(X, Y)|T]):-
	X2 is X-1, Y2 is Y-1, Limit is X-Y+1,
	diagonal_left_half_2(X2, Y2, Limit, T).
diagonal_left_half_2(X, Y, Limit, [(X, Y)]):-
	X = Limit.
diagonal_left_half_2(X, Y, Limit, [(X, Y)|T]):-
	X > Limit,
	X2 is X-1, Y2 is Y-1,
	diagonal_left_half_2(X2, Y2, Limit, T).
% ---------------------------------------------------------------------------------------------------------

empate(E):-
	all_atomics(E), asserta(empate).

all_atomics([]).
all_atomics([(p(_,_), X)|T]):-nonvar(X),all_atomics(T).

ciclo_jogada(_,(E,J)):- (linhas(E);colunas(E);diagonais(E)), print_(E),write('Vencedor: '),write(J),!.
ciclo_jogada(_,(E,_)):- empate(E), print_(E),write('Empate!'),nl,!.

ciclo_jogada('c',(E,J)):-
	print_(E),
	nl,statistics(real_time,[Ti,_]),
	alfabeta_decidir((E,J),Op),
	statistics(real_time,[Tf,_]), T is Tf-Ti,
	nl, 
	write('Tempo: '(T)),
	nl,
	n(N),
	write('Numero de Nós: '(N)),
	initInc,	
	nl,
	write(Op),
	nl,
	nl,
	op1((E,J),Op,Es),
	ciclo_jogada('j',Es).

ciclo_jogada('j',(E,J)):-
	print_(E),
	nl,
	write('Escreva a coluna onde deseja inserir a peca: '),
	read(X),
	inverteJog(J,J1),
	op1((E,J),insere_coluna(X,J1),Es),
	ciclo_jogada('c',Es).

inverteJog('x','o').
inverteJog('o','x').

op1((E,O), insere_coluna(X,P), (E,P)):-
	member(X, [1,2,3,4,5,6,7]),
	inverteJog(O,P),	
	insere(X, P, E).

insere(Coluna, J, E):-
	findall(X, member((p(_,Coluna), X), E), L), 
	reverse(L, L2), posicao(L2, Linha), 
	member((p(Linha,Coluna), J), E).

%------------------------------------ Função de avaliação ----------------------------------------------------

% conta o numero total de 1x's ou 1o's 
find_all_1peca(E, J, V):-
	%encontra todos os membros nao atomicos do estado
	findall((p(X,Y), J1), (member((p(X,Y), J1), E),atom(J1)), L),
	findall(J, find_1peca(L, J), L2),
	length(L2, V).

% encontrar num. de 1x's ou 1o's na linha
find_1peca(E, J):-
	member((p(X,Y), J), E),
	X1 is X+1, X2 is X-1,
	Y1 is Y-1, Y2 is Y+1,
	\+ member((p(X,Y1),J), E), \+ member((p(X,Y2),J), E), \+ member((p(X1,Y),J), E), 
	\+ member((p(X2,Y),J), E), \+ member((p(X1,Y1),J), E), \+ member((p(X2,Y2),J), E), 
	\+ member((p(X1,Y2),J), E), \+ member((p(X2,Y1),J), E).

% conta o numero total de 2x's ou 2o's 
find_all_2pecas(E, J, V):-
	findall((p(X,Y), J1), (member((p(X,Y), J1), E),atom(J1)), L),
	findall(J, find_2pecas(L, J), L2),
	length(L2, V).

% encontrar num. de 2x's ou 2o's na linha
find_2pecas(E, J):-
	member((p(X,Y), J), E),
	Y1 is Y-1,
	member((p(X,Y1),J), E).

% encontrar num. de 2x's ou 2o's na coluna
find_2pecas(E, J):-
	member((p(X,Y), J), E),
	X1 is X-1,
	member((p(X1,Y),J), E).

%diagonal 1
find_2pecas(E, J):-
	member((p(X,Y), J), E),
	X1 is X-1, Y1 is Y-1,
	member((p(X1,Y1),J), E).

%diagonal 2
find_2pecas(E, J):-
	member((p(X,Y), J), E),
	X1 is X-1, Y1 is Y+1,
	member((p(X1,Y1),J), E).

% conta o numero total de 3x's ou 3o's 
find_all_3pecas(E, J, V):-
	findall((p(X,Y), J1), (member((p(X,Y), J1), E),atom(J1)), L),
	findall(J, find_3pecas(L, J), L2),
	length(L2, V).

% encontrar num. de 3x's ou 3o's na linha
find_3pecas(E, J):-
	member((p(X,Y), J), E),
	Y1 is Y+1,
	Y2 is Y+2,
	member((p(X,Y1),J), E), member((p(X,Y2),J), E).

% encontrar num. de 3x's ou 3o's na coluna
find_3pecas(E, J):-
	member((p(X,Y), J), E),
	X1 is X+1,
	X2 is X+2,
	member((p(X1,Y),J), E), member((p(X1,Y),J), E).

%diagonal 1
find_3pecas(E, J):-
	member((p(X,Y), J), E),
	X1 is X+1, Y1 is Y+1, X2 is X+2, Y2 is Y+2,
	member((p(X1,Y1),J), E), member((p(X2,Y2),J), E).

%diagonal 2
find_3pecas(E, J):-
	member((p(X,Y), J), E),
	X1 is X+1, X2 is X+2, Y1 is Y-1, Y2 is Y-2,
	member((p(X1,Y1),J), E), member((p(X1,Y1),J), E).
	

% avalia(Estado, Tipo_peca, Avaliacao)
% dados um estado, um tipo de peca, returna em C o valor da avaliacao
func_aval((E,J), Val,_):-
	inverteJog(J, J2),
	aval(E,J2,Val).

aval(E, J, Val):-
	find_all_1peca(E, J, V1),
	find_all_2pecas(E, J, V2),
	find_all_3pecas(E, J, V3),
	Val1 is V1+(3*V2)+(6*V3),
	inverteJog(J, J2),
	find_all_1peca(E, J2, V4),
	find_all_2pecas(E, J2, V5),
	find_all_3pecas(E, J2, V6),	
	Val2 is V4+(3*V5)+(6*V6),
	Val is Val1-Val2.

%aval(E,J,Val):-
%	valor(E,V,_),
%	Val is V*100.

inverteJog('x','o').
inverteJog('o','x').

op1((E,O), insere_coluna(X,P), (E,P)):-
	member(X, [1,2,3,4,5,6,7]),
	inverteJog(O,P),	
	insere(X, P, E).

insere(Coluna, J, E):-
	findall(X, member((p(_,Coluna), X), E), L), 
	reverse(L, L2), posicao(L2, Linha), 
	member((p(Linha,Coluna), J), E).

% -------------------------- Calcula a posicao em que a peca vai ser inserida -----------------------------

posicao(L, P):-
	posicao(L, 1, P).
posicao([], _, _):-fail.
posicao([H|T], Linha, Linha3):-
	atom(H), Linha2 is Linha+1,
	posicao(T, Linha2, Linha3).
posicao([H|_], Linha, Linha2):-
	\+atom(H), Linha2 is 6-(Linha-1).
posicao([H|_], 1, 6):-
	\+atom(H).
% ---------------------------------------------------------------------------------------------------------

print_(E):-
	print_linhas(E).

print_linhas(E):-
	write('       | '),
	print_linha(E, 1, 1),
	write('       | '),
	write_line(1, 12),
	write('       | '),
	print_linha(E, 2, 1),
	write('       | '),
	write_line(1, 12),
	write('       | '),
	print_linha(E, 3, 1),
	write('       | '),
	write_line(1, 12),
	write('       | '),
	print_linha(E, 4, 1),
	write('       | '),
	write_line(1, 12),
	write('       | '),
	print_linha(E, 5, 1),
	write('       | '),
	write_line(1, 12),
	write('       | '),
	print_linha(E, 6, 1),
	write('\n\n').

print_linha(E, I, J):-
	member((p(I,J), X), E),
	J = 7,
	write_last_element(X),write('|\n').

print_linha(E, I, J):-
	\+member((p(I,J), X), E),
	J = 7,
	write_last_element(X).

print_linha(E, I, J):-
	J < 7, J2 is J+1,
	member((p(I,J), X), E),
	write_elements(X),
	print_linha(E, I, J2).

print_linha(E, I, J):-
	J < 7, J2 is J+1,
	\+member((p(I,J), X), E),
	write_elements(X),
	print_linha(E, I, J2).

write_elements(X):-
	nonvar(X),
	write(X),write(' | ').
write_elements(X):-
	\+ nonvar(X),
	write(' '),write(' | ').
write_last_element(X):-
	nonvar(X),
	write(X),write(' ').
write_last_element(X):-
	\+ nonvar(X),
	write('  ').


write_line( I, P):-
        I = P, write('- - -'), nl.
write_line( I, P):-
        I < P, I2 is I+1,
        write('- '),
        write_line(I2, P).

