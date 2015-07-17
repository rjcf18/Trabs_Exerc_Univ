natural_number(0).

natural_number(s(X)):-
	natural_number(X).

less(0, s(X)):-
	natural_number(X).

less(s(X), s(Y)):-
	less(X, Y).

plus(0, X, X):-
	natural_number(X).

plus(s(X), Y, s(Z)):-
	plus(X,Y,Z).

times(0,_,0).

times(s(X), Y, Z):-
	times(X,Y,W),
	plus(W, Y, Z).

exp(X, s(0), X).
exp(_, 0, s(0)).
exp(X, s(Y), Z):-
	exp(X,Y,Z1),
	times(X, Z1, Z).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lista([]).

lista([_|Xs]):-
	lista(Xs).

double([],[]).
double([X|Xs], [X|[X|Ys]]):-
	double(Xs,Ys).

adjacente(X,Y,[X|[Y|_]]).

adjacente(X,Y,[_|Zs]):-
	adjacente(X,Y,Zs).

select1(X,[X|Ys],Ys).
select1(X,[Y|Zs],[Y|Ys]):-
	select1(X,Zs,Ys).

select2(_,[],[]).
select2(X,[X|Xs],Ys):-
	select2(X,Xs,Ys).

select2(X,[Q|Xs],[Q|Ys]):-
	X\=Q,
	select2(X,Xs,Ys).








