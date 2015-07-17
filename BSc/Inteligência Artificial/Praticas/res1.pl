
mundo(5,5).

esta(1,1, 1).
esta(2,1, 2).
esta(1,2, 3).
esta(1,3, 4).
esta(2,3, 5).
%esta(4,2, 6).

adjacente(X,Y,W,Y):- W is X+1, mundo(Mx,_), W =< Mx.
adjacente(X,Y,X,Z):- Z is Y+1, mundo(_,My), Z =< My.
adjacente(X,Y,W,Y):- W is X-1, W > 0.
adjacente(X,Y,W,Y):- W is Y-1, W > 0.

% casa é segura se já la esteve ou se 
segura(X,Y):-
	esta(X,Y,_).

segura(X,Y):-
	esta(W,Z,_),
	adjacente(W,Z,X,Y),
	\+ brisa(W,Z), \+ cheiro(W,Z).

cheiro(2,4).
brisa(2,1).


%% ja da as casas seguras correctamente
casas_seguras:- mundo(Mx,My), intsI_a_J(1,Mx,L1), intsI_a_J(1,My,L2), 
		findall((X,Y),(member(Y, L1), member(X, L2), segura(X,Y)), L3), sort(L3,L4), write(L4).


casas_Nseguras:- mundo(Mx,My), intsI_a_J(1,Mx,L1), intsI_a_J(1,My,L2), 
		findall((X,Y),(member(Y, L1), member(X, L2), \+ segura(X,Y)), L3), sort(L3,L4), write(L4).


%%% Todos os inteiros no intervalo entre I e J
intsI_a_J(I,J,L):-
	findall(N, entre(I,J,N), L).

entre(I,J,I) :-
	I =< J.

entre(I,J,K) :-
	I < J,
	I1 is I + 1,
	entre(I1,J,K).
