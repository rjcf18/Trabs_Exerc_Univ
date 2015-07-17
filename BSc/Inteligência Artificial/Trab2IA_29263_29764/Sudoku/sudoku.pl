tamanho_tabuleiro(9). %(9x9)

estado_inicial(E):-
	gerar_estado(E1),
	preencher_posicoes(E1, E).

gerar_estado(E):-
	functor(E, e, 2), arg(1, E, T), arg(2, E, []),
	tamanho_tabuleiro(S),
        gerar_tab(T2, S),
	flatten(T2, T).

% -----------------------------------------------------------
% para preencher o tabuleiro basta adicionar uma variavel à lista L
% o exemplo seguinte preenche a posicao (1, 1) to tabuleiro com 2
% ex: L = [v(P(1,1), [1,2,3,4,5,6,7,8,9], 2)]
preencher_posicoes(E, NE):-
	L = [v(p(9,9),[1,2,3,4,5,6,7,8,9],9)],
	E = e(NAfect, []),
	NE = e(NAfect2, Afect),
	preencher(NAfect, L, NAfect2, Afect).

preencher([H], L, [H], []):-
        H  = v(P, D, V),
        \+member(v(P, D, V), L).

preencher([H], L, [], [v(P, D, V)]):-
        H  = v(P, D, V),
        member(v(P, D, V), L).

preencher([H|T], L, [H|T2], Resto):-
        H  = v(P, D, V),
        \+member(v(P, D, V), L),
	preencher(T, L, T2, Resto).

preencher([H|T], L, T2, [v(P, D, V)|Resto]):-
	H  = v(P, D, V),
	member(v(P, D, V), L),
	preencher(T, L, T2, Resto).

% -----------------------------------------------------------

gerar_tab(L, Size):- 
	gerar_tab(L, 1, Size).
gerar_tab([H], N, N):-
	gerar_coluna(H, N, N).
gerar_tab([H|T], J, N):-
	J < N, J2 is J+1,
	gerar_coluna(H, J, N),
	gerar_tab(T, J2, N).
	
gerar_coluna(L, J, NColunas):- 
	gerar_coluna(L, 1, J, NColunas).
gerar_coluna([H], N, J, N):-
	tamanho_tabuleiro(S),
	range(1, S, D), %cria o dominio da variavel dado um maximo como arg
	H = v(p(N, J), D, _).
gerar_coluna([H|T], I, J, N):-
	tamanho_tabuleiro(S),
	range(1, S, D), %cria o dominio da variavel dado um maximo como arg
	I < N, I2 is I+1,
	H = v(p(I, J), D, _),
	gerar_coluna(T, I2, J, N).

%devolve uma lista com numeros de I a J
range(I,I,[I]).
range(I,J,[I|L]) :- I < J, I1 is I + 1, range(I1,J,L).		


%ve_restricoes(e(Nafec,Afect)):- 
ve_restricoes(E):-
	ver_linhas(E), 
	ver_colunas(E), 
	ver_quadrantes(E).	   

ver_linhas(e(Nafect,[v(p(X,Y), D, V)|R])):-
	findall(V1,member(v(p(X,_),_,V1),R),L), todos_diff([V|L]).

ver_colunas(e(Nafect,[v(p(X,Y), D, V)|R])):-
	findall(V1,member(v(p(_,Y),_,V1),R),L), todos_diff([V|L]).

ver_quadrantes(e(_, Afect)):-
	%ve o primeiro quadrante 
	ver_quadrante(Afect, 1, 1, 3, Q1),
	todos_diff(Q1),
	%ve o segundo quadrante
	ver_quadrante(Afect, 1, 4, 6, Q2),
	todos_diff(Q2),
	%ve o terceiro quadrante
	ver_quadrante(Afect, 1, 7, 9, Q3),
	todos_diff(Q3),
	%ve o quarto quadrante
	ver_quadrante(Afect, 4, 1, 3, Q4),
	todos_diff(Q4),
	%ve o quinto quadrante
	ver_quadrante(Afect, 4, 4, 6, Q5),
	todos_diff(Q5),
	%ve o sexto quadrante
	ver_quadrante(Afect, 4, 7, 9, Q6),
	todos_diff(Q6),
	%ve o sétimo quadrante
	ver_quadrante(Afect, 7, 1, 3, Q7),
	todos_diff(Q7),
	%ve o oitavo quadrante
	ver_quadrante(Afect, 7, 4, 6, Q8),
	todos_diff(Q8),
	%ve o nono quadrante
	ver_quadrante(Afect, 7, 7, 9, Q9),
	todos_diff(Q9).


ver_quadrante(L, X, Y, Y2, L2):-
	Y = Y2, X1 is X+2,
	ver_q_c(L, X, Y, X1, L2).

ver_quadrante(L, X, Y, Y2, L3):-
	Y < Y2, Y1 is Y+1,
	X1 is X+2,
	ver_q_c(L, X, Y, X1, L1),
	append(L1, L2, L3),
	ver_quadrante(L, X, Y1, Y2, L2).

ver_q_c(L, X, Y, X2, []):-
	X = X2,
	\+member(v(p(X, Y), _, _), L).

ver_q_c(L, X, Y, X2, [V]):-
        X = X2,
        member(v(p(X,Y), _, V), L).

ver_q_c(L, X, Y, X2, T):-
        X < X2, X1 is X+1,
        \+member(v(p(X, Y), _, _), L),
	ver_q_c(L, X1, Y, X2, T).

ver_q_c(L, X, Y, X2, [V|T]):-
	X < X2, 
        member(v(p(X,Y), _, V), L),
	X1 is X+1,
        ver_q_c(L, X1, Y, X2, T).

%verifica se os elementos numa lista sao todos diferentes
todos_diff([]).
todos_diff([X|R]):-
	\+ member(X,R), todos_diff(R).
	
% ------------------------------------------------
increment(X, N, N2):-
	X = 1, N2 is N+1,
	N2 < 3.
increment(X, N, N2):-
	X = 0, N2 = 0.
	
%escreve a solucao no terminal
esc(L):-sort(L, L1), write(L1),nl, esc_a(L1),nl.
esc_a(L):-tamanho_tabuleiro(S),nl, esc_l(L, 1, S).

esc_l([H], S, S):-
	H = v(_,_,X), write(X), nl.

esc_l([H|T], S, S):-
	H = v(P, _, V), write(V),
	P = p(X, _),
	my_line(X, 9),
	esc_l(T, 1, S).

esc_l([H|T], I, S):- 
	I<S, I2 is I+1,
	H = v(_,_,X), write(X),my_print(I),
	esc_l(T, I2, S).

my_print(X):-
	R is X mod 3,
	R=0, 
	write(' | ').
my_print(X):-
	R is X mod 3,
	R \= 0,
	write(' ').

my_line(P, _):-
	R is P mod 3,
	R \= 0, nl.
my_line(P, S):-
	R is P mod 3,
	R = 0,
	nl, write_line(1, S).

write_line( I, P):-
	I = P, write('- - -'), nl.
write_line( I, P):-
	I < P, I2 is I+1,
	write('- '),
	write_line(I2, P).

%retira uma ocorrencia de um valor no dominio de uma variavel
remove_valor(Valor, [], []) :- !.
remove_valor(Valor, [Valor|R], L) :- !, remove_valor(Valor, R, L).
remove_valor(Valor, [T|R], L) :- !, remove_valor(Valor, R, L2), append([T], L2, L).

%percorre as nao afectadas e remove o valor do dominio
forward_Checking(E,NE):-
	cut_linha(E,NE1),
	cut_coluna(NE1,NE).


cut_linha(e(Nafect,[v(p(X,Y), D, V)|R]), NE):-
	member(v(p(X,_),_,V1),R), 
	percorre_linha(V1,X,e(Nafect,[v(p(X,Y), D, V)|R]), NE).

cut_coluna(e(Nafect,[v(p(X,Y), D, V)|R]), NE):-
	member(v(p(_,Y),_,V1),R), 
	percorre_coluna(V1,Y,e(Nafect,[v(p(X,Y), D, V)|R]), NE).



% Substitui as variaveis nas em que o dominio foi alterados
criar_nova_lista([H], [H], L):-
	H = v(p(X, Y), _, _),
	\+member(v(p(X, Y), D, _), L).

criar_nova_lista([H], [v(p(X, Y), D, _)], L):-
	H = v(p(X, Y), _, _),
	member(v(p(X, Y), D, _), L).

criar_nova_lista([H|T], [H|T2], L):-
	H = v(p(X, Y), _, _),
	\+member(v(p(X, Y), D, _), L),
	criar_nova_lista(T, T2, L).

criar_nova_lista([H|T], [v(p(X, Y), D, _)|T2], L):-
	H = v(p(X, Y), _, _),
	member(v(p(X, Y), D, _), L),
	criar_nova_lista(T, T2, L).


% Reduz o dominio de uma percorre_linha
% Cria uma lista com as novas variaveis
percorre_linha(V, X, E, NE):-
	E = e(NAfect,Afect),
	NE = e(NAfect2, Afect),
	percorre_linha(V, NAfect, L, X, 1),
	criar_nova_lista(NAfect, NAfect2, L).

percorre_linha( Valor, L, [], X, I):-
	I = 9,
	\+member(v(p(X, I), _, _), L).

percorre_linha( Valor, L, [v(p(X, I), D1, _)], X, I):-
	I = 9,
	member(v(p(X, I), D, _), L),
	remove_valor(Valor, D, D1).

percorre_linha( Valor, L, T, X, I):-
	I < 9, I2 is I+1,
	\+member(v(p(X, I), _, _), L),
	percorre_linha(Valor, L, T, X, I2).

percorre_linha( Valor, L, [v(p(X, I), D1, _)| T], X, I):-
	I < 9, I2 is I+1,
	member(v(p(X, I), D, _), L),
	remove_valor(Valor, D, D1),
	percorre_linha(Valor, L, T, X, I2).


% Reduz o dominio de uma percorre_linha
% Cria uma lista com as novas variaveis
percorre_coluna(V, Y, E, NE):-
	E = e(NAfect,Afect),
	NE = e(NAfect2, Afect),
	percorre_coluna(V, NAfect, L, Y, 1),
	criar_nova_lista(NAfect, NAfect2, L).

percorre_coluna( Valor, L, [], Y, I):-
	I = 9,
	\+member(v(p(I, Y), _, _), L).

percorre_coluna( Valor, L, [v(p(I, Y), D1, _)], Y, I):-
	I = 9,
	member(v(p(I, Y), D, _), L),
	remove_valor(Valor, D, D1).

percorre_coluna( Valor, L, T, Y, I):-
	I < 9, I2 is I+1,
	\+member(v(p(I, Y), _, _), L),
	percorre_coluna(Valor, L, T, Y, I2).

percorre_coluna( Valor, L, [v(p(I, Y), D1, _)| T], Y, I):-
	I < 9, I2 is I+1,
	member(v(p(I, Y), D, _), L),
	remove_valor(Valor, D, D1),
	percorre_coluna(Valor, L, T, Y, I2).

