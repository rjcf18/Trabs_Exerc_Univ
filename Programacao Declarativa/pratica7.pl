min_lista([H|T], Min) :-
	min_lista(T, H, Min).

min_lista([], Min, Min).
min_lista([H|T], Min0, Min) :-
 	Min1 is min(H, Min0),
 	min_lista(T, Min1, Min).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Freq ex. 6

inicializar(N,M,Matriz):-
	functor(Matriz, matriz,N),
	Matriz =..[_|Linhas],
	linhas(M,Linhas).

linhas(_,[]).
linhas(N,[X|Xs]):-
	functor(X,linha,N),
	linhas(N,Xs).

posicao(I,J,V,Matriz):-
	arg(I,Matriz,LinhaI),
	arg(J,LinhaI,V).

functor_user(Termo,Functor,Aridade):-
	length(Xs,Aridade),
	Termo =.. [Functor|Xs].

arg_user(N,Termo,Arg):-
	Termo =.. [_|Xs],
	arg_aux(N,Xs,Arg).

arg_aux(1,[X|_],X).
arg_aux(N,[_|Xs],X):-
	N<1,
	N1 is N-1,
	arg_aux(N1, Xs,X).

xor(A,B):-
	(A;B),!, \+ (A,B).
