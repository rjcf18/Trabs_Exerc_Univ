:- dynamic(h/2).
:- dynamic(segura/2).
:- dynamic(minas/3).

mundo(6,6).

go:-	
%	retractall(segura(_,_)),
	andar(s0),!.

andar(S):- 
	h(ganhou,S), 
	write('[GANHOU]'),nl,!.

andar(S) :-
	h(desistiu,S),
	write('[DESISTIU]'),nl,!.

andar(s0) :-
	h(estar(X,Y),S),
	write('Percepcao na situacao apos: '),
	write(' Em '), write(pos(X,Y)),nl,
	write(' o que? '), read(P),!,
	tell(kb,percepcao([P],S)),
	ask(kb,accao(A,S)),nl,write('Faz '),write(A),nl,
	andar(r(A,S)). 

%se ainda não visitou a casa pede a percepcao
andar(S):- 	
	r(A0,S1)=S, 
	h(estar(X,Y),S),
	\+ h(visitada(X,Y),S1),!,
	write('Percepcao na situacao apos: '),
	h(estar(X,Y),S),
	write(A0), 
	write(' Em '), 
	write(pos(X,Y)),nl,
	write(' o que? '), nl,
	read(P),!,
	tell(kb,percepcao([P],S)),
	ask(kb,accao(A,S)),
	write('Faz '),write(accao(A,S)),nl,
	andar(r(A,S)).

%se já visitou a casa não pede a percepcao
andar(S):- 	
	h(estar(X,Y),S), 
	write(' Em '), 
	write(pos(X,Y)),nl,
	ask(kb,accao(A,S)),nl,write('Faz '),write(accao(A,S)),nl,
	andar(r(A,S)).

%%%% FALTA O RESTO DO ANDAR E OS ASK'S

%Prefere ganhar se puder
ask(kb,accao(A,S)):- h(ganhou,r(A,S)).

%O agente deve procurar ir para uma casa que ainda não visitou.
ask(kb,accao(move(P),S)):- h(estar(X,Y),S),
			val(W,Z,X,Y,P),
			\+ h(visitada(W,Z),S), h(segura(W,Z), S).

%O agente deve procurar ir para uma casa que já visitou.
ask(kb,accao(move(P),S)):- h(estar(X,Y),S),
			val(W,Z,X,Y,P),
			h(visitada(W,Z),S).

%%## Guarda as percepcoes ##%% 
tell(kb,percepcao([],_)).
tell(kb,percepcao([nada],_)).
tell(kb,percepcao([A|R],S)):- asserta(h(A,_)), tell(kb,percepcao(R,S)).

%%## estado inicial ##%%
h(estar(1,1),s0).

%%####### CONSEQUENCIAS #######%%

%% mover
h(estar(X,Y),r(move(P),S)):- 
	h(estar(K,W),S),
	val(X,Y,K,W,P).

%%### ganhou ###%%
h(ganhou,r(_,S)):- 
	h(ganhou,S).

%%### desiste ###%%
h(desistiu,r(_,S)) :-
	h(desistiu,S).

h(estar(X,Y),r(sair,S)):- 
	h(estar(X,Y),S).

%Acção desistir
h(perdeu,r(desistir,S)):- h(estar(_X,_Y),S).


h(visitada(X,Y),S):-
	nonvar(S), 
	h(estar(X,Y),S).

h(visitada(X,Y),S1):- nonvar(S1), S1 = r(_,S), 
	h(visitada(X,Y),S). 

%h(segura(X,Y),S) :-
%	segura(X,Y).

% casa é segura se já la esteve ou se 
h(segura(X,Y),S):-
	%write(1),nl,
	h(visitada(X,Y),S).

h(segura(X,Y),S):-
	%write(2),nl,
	h(visitada(W,Z),S),
	adjacente(X,Y,W,Z),
	h(minas(W,Z,N),S), N == 0.

%A casa (X,Y) permanece como casa de saida em S,independentemente da acção que efectue em S
h(saida(X,Y),r(_,S)):- h(saida(X,Y),S).

h(ganhou,r(sair,S)):- h(estar(X,Y),S), h(saida(X,Y), S).	
 
adjacente(X,W,X,Y):- W is Y+1, mundo(_,My), W =< My.  
adjacente(X,W,X,Y):- W is Y-1, W>0.
adjacente(K,Y,X,Y):- K is X-1, K>0.
adjacente(K,Y,X,Y):- K is X+1, mundo(Mx,_), K =< Mx. 

%%### uma casa é a saida se o agente sentir brisa ###%%
h(saida(X,Y),r(_,S)):- 
	h(brisa,S),
	h(estar(X,Y),S).


%%%val - auxiliar para calcular as posições de acordo com os movimentos
val(X,W,X,Y,cima):- W is Y+1, mundo(_,My), W =< My.  
val(X,W,X,Y,baixo):- W is Y-1, W>0.
val(K,Y,X,Y,esq):- K is X-1, K>0.
val(K,Y,X,Y,dir):- K is X+1, mundo(Mx,_), K =< Mx. 



