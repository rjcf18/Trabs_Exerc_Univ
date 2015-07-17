conectado(a,b).
conectado(a,c).
conectado(c,d).
conectado(d,b).
conectado(d,p).
conectado(e,u).

caminho(X,X).
caminho(X,Y):-
	conectado(X,Y).
caminho(X,Y):-
	conectado(X,Z),
	caminho(Z,Y),
	Z\=Y.

