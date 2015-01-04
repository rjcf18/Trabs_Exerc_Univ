echo:-
  repeat_, read(X),echo(X), !.

echo(X):- last_input(X),!.
echo(X):- write(X),nl, fail.

repeat_.
repeat_:- repeat_.

% append 2 diferenças de listas
append_dl(Xs-Ys,Ys-Zs,Xs-Zs).

append(X,Y,Z):-
  append_dl([X|Xs]-Xs,Y-[],Z1-_), flatten(Z1,Z).

%flatten de uma lista de listas usando diferenças de listas
flatten(Xs,Ys):- flatten_dl(Xs, Ys-[]).

flatten_dl([X|Xs],Ys-Zs):-
  flatten_dl(X,Ys-Ys1), flatten_dl(Xs,Ys1-Zs).
flatten_dl(X,[X|Xs]-Xs):-
  atomic(X), \+ X = [].
flatten_dl([],Xs-Xs).

reverse(Xs,Ys):- reverse_dl(Xs,Ys-[]).
reverse_dl([X|Xs], Ys-Zs):-
  reverse_dl(Xs,Ys-[X|Zs]).
reverse_dl([],Xs-Xs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arco(b,a).
arco(a,b).
arco(b,c).
arco(c,d).


caminho(X,Y,_):-
  arco(X,Y).
caminho(X,Y,Path):-
  arco(X,Z), \+ member(Z,Path),
  caminho(Z,Y,[Z|Path]), Z\=Y.

nos_acessiveis(A,L):-
  findall(X, caminho(A,X,[]), L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nota(pedro, pd, 14).
nota(ana, pd, 16).
nota(pedro, p1, 17).
nota(ana, p1, 17).

% loop failure-driven
disc_notas:-
  nota(_,D,N), write(D), write(' '), write(N),nl,fail.

last_el([X],X).
last_el([_|Xs],X):-
  last_el(Xs,X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

take(N,L):-
	L = [1,2|_],
	take1(N,L).

take1(2,[_,_|[]]).
take1(N,[E1,E2|Es]):-
	E3 is E2 + E2 - E1,	
	Es = [E3|_], N1 is N-1,
	take1(N1,[E2|Es]).
