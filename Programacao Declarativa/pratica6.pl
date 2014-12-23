lista_ligada(fim).
lista_ligada(lista(_,L)):-
	lista_ligada(L).

elementos(fim,[]).
elementos(lista(E,L),[E|Es]):-
	elementos(L,Es).

lista_ligada_inteiros(fim).
lista_ligada_inteiros(lista(E,L)):-
	integer(E),	
	lista_ligada_inteiros(L).

%4.4  1.0
ordenada(fim).
ordenada(lista(_,fim)).
ordenada(L):-
	L = lista(E,L2),
	L2 = lista(E2, _),
	E > E2, ordenada(L2), !.
ordenada(L):-
	L = lista(E,L2),
	L2 = lista(E2, _),
	E < E2, ordenada(L2).


%4.4 2.0
ordenada2(fim, _).
ordenada2(lista(_, fim), _).
ordenada2(lista(X,lista(Y,L)),Op):-
	Z=.. [Op,X,Y], call(Z), ordenada2(lista(Y,L),Op).

% 3
conjunto([]).
conjunto([X|Xs]):-
	\+member(X,Xs),
	conjunto(Xs).

%2.1

filme('Accao', 'Avengers', 'Joss Whedon', 2012, ['Robert Downey, Jr', 'Chris Evans', 'Mark Ruffalo', 'Scarlett Johansson','Jeremy Renner']).
filme('Accao', 'Adasdasasd', 'Cenas', 2012, ['addas', 'Chris Evans', 'Mark Ruffalo', 'Scarlett Johansson','Jeremy Renner']).

%2.2
obtem_realizadores(Rs):-
	findall(R,filme(_,_,R,_,_),Rs).

