estado_inicial((a, (1,1))).
estado_final((_, (0,0))).

%op(estado, operacao, seguinte, custo).

op(E, d, NE, 1):-
	E = (P, T),
	P \= a,
	NE = (a, T).

op(E, e, NE, 1):-
	E = (P, T),
	P \= b,
	NE = (b, T).

op(E, limpa, NE, 1):-
	E = (P, T),
	P == a,
	T = (X,Y),
	NT = (0, Y),
	NE = (P, NT).

op(E, limpa, NE, 1):-
	E = (P, T),
	P == b,
	T = (X,Y),
	NT = (X, 0),
	NE = (P, NT).


