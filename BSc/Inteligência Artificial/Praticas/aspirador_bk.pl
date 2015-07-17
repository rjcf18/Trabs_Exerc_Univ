
%estado ---> (salaInicial,listaDasSalas)

%estadoInicial

estadoInicial((1,1,L)):-
	tamanho(X,Y),
	criaSalas(X,Y,L).









%op(Estado_act,operador,Estado_seg,Custo)
op((A,B,T),esq,(A,B1,T),1):- 
	B > 1,
	B1 is B-1.
op((A,B,T),dir,(A,B1,T),1):-
	tamanho(_,Y),
	B < Y,
	B1 is B+1.
op((A,B,T),cima,(A1,B,T),1):-
	A > 1,
	A1 is A-1.
op((A,B,T),baixo,(A1,B,T),1):-
	tamanho(X,_),
	A < X,
	A1 is A+1.
op((A,B,T),aspirar,(A,B,NT),1):-
	limpaSala(A,B,T,NT).

impar(X):-
	Y is X mod 2,
	Y \= 0.


