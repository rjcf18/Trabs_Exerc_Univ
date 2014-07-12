%exemplo para teste
%XXSX4
% XSX3
% X X2
% O X1
%1234

:-dynamic(h/2).

mundo(5,5).	

%%% WUMPUS - Apenas buracos %%%

%buraco(X,Y) -- é verdade se a casa(X,Y) tem um buraco
%casa_segura(X,Y) -- é verdade se a casa(X,Y) nao tiver buraco ou se não sentir brisa
%visitada(X,Y) -- é verdade se a casa (X,Y) já foi visitada pelo agente. 
%esta(X,Y) -- é verdade se o agente está na casa (X,Y).
%saida(X,Y) -- é verdade se a casa (X,Y) tem a saída do labirinto.

% mover(X) -- com X pertence {cima, baixo, esquerda, direita}.
% sair

% brisa.

go:- andar(s0).

andar(S):- 
	h(ganhou,S), 
	write('Ganhou'),nl.

%se ainda não visitou a casa pede a percepcao
andar(S):- 	
	r(A0,S1)=S, 
	h(esta(X,Y),S),
	\+ h(visitada(X,Y),S1),
	write('Percepcao na situacao apos: '),
	h(esta(X,Y),S),
	write(A0), 
	write('Em '), 
	write(pos(X,Y)),nl,
	write(' o que? '), nl,
	read(P),!,
	tell(kb,percepcao([P],S)),
	ask(kb,accao(A,S)),
	write('Faz '),write(A),nl,
	andar(r(A,S)).

%se já visitou a casa não pede a percepcao
andar(S):- 	
	h(esta(X,Y),S), 
	write('Em '), 
	write(pos(X,Y)),nl,
	ask(kb,accao(A,S)),nl,write('Faz '),write(A),nl,
	andar(r(A,S)).

%Guarda percepcoes
tell(kb,percepcao([],_)).
tell(kb,percepcao([nada],_)).
tell(kb,percepcao([A|R],S)):- 
	asserta(h(A,S)), 
	tell(kb,percepcao(R,S)).

%Interpretação do ask
%codifica a escolha da melhor accao: ordem dos predicados

%Descrição do problema

%estado inicial
h(esta(1,1),s0).

%Prefere ganhar se puder
ask(kb,accao(A,S)):- h(ganhou,r(A,S)).

%O agente deve procurar ir para uma casa que ainda não visitou.
ask(kb,accao(mover(cima),S)):- h(esta(X,Y),S),
			Y1 is Y+1, mundo(_,My), Y1=<My,
			\+ h(visitada(X,Y1),_).

ask(kb,accao(mover(direita),S)):- h(esta(X,Y),S),
			X1 is X+1, mundo(Mx,_), X1=<Mx,
			\+ h(visitada(X1,Y),_).

ask(kb,accao(mover(baixo),S)):- h(esta(X,Y),S),
			Y1 is Y-1, Y1>0,
			\+ h(visitada(X,Y1),_).

ask(kb,accao(mover(esquerda),S)):- h(esta(X,Y),S),
			X1 is X-1, X1>0,
			\+ h(visitada(X1,Y),_).

%O agente deve procurar uma casa segura para seguir.
ask(kb,accao(mover(cima),S)):- h(esta(X,Y),S),
			Y1 is Y+1, mundo(_,My), Y1=<My,
			\+ h(casa_Nsegura(X,Y1),S).

ask(kb,accao(mover(direita),S)):- h(esta(X,Y),S),
			X1 is X+1, mundo(Mx,_), X1=<Mx,
			\+ h(casa_Nsegura(X1,Y),S).

ask(kb,accao(mover(baixo),S)):- h(esta(X,Y),S),
			Y1 is Y-1, Y1>0,
			\+ h(casa_Nsegura(X,Y1),S).

ask(kb,accao(mover(esquerda),S)):- h(esta(X,Y),S),
			X1 is X-1, X1>0,
			\+ h(casa_Nsegura(X1,Y),S).


%%%% Consequencias das acções

%Acção sair
h(ganhou,r(sair,S)):- h(esta(X,Y),S), saida(X,Y).

%Acção Mover
%mover(X)
h(esta(X,Y),r(mover(P),S)):- 
	h(esta(K,W),S),
	val(X,Y,K,W,P),
	\+ h(brisa,r(mover(P),S)).

%Acção desistir
h(perdeu,r(desistir,S)):- h(esta(_X,_Y),S).



%O agente mantem-se na casa(X,Y), se realizar a acção sair em S e não tem a perceção da brisa em S
h(esta(X,Y),r(sair,S)):- h(esta(X,Y),S), \+ h(brisa,S).

%%%%% Inércia - condições em que um fluente mantem o valor

direcao(X):- member(X, [cima,baixo,direita,esquerda]).

%O agente mantem-se na casa (X,Y), se realizar a acção mover em S e tem a perceção da brisa apos tentar mover para qualquer lado
h(esta(X,Y),r(mover(Z),S)) :- direcao(Z), 
			h(esta(X,Y),S), 
			h(brisa,r(mover(Z),S)).

%A casa (X,Y) mantem-se não segura em S, se realizar a acção mover em S 
h(casa_Nsegura(X,Y),r(mover(Z),S)):- 
		direcao(Z), 
		h(casa_Nsegura(X,Y),S).

%outras regras

%visitada - não é um condição primitiva é definida usando o fluente esta
% uma casa foi visitada se o agente já lá esteve
h(visitada(X,Y),S):- h(esta(X,Y),S).
h(visitada(X,Y),r(_,S)):- h(visitada(X,Y),S).

h(saida(X,Y),r(_,S)):- h(saida(X,Y),S). 

%Fluente ganhou
h(ganhou,r(_,S)):- h(ganhou,S).

%Fluente perdeu
h(perdeu,r(_,S)):- h(perdeu,S).

%Se estou em (X,Y), então a casa(X,Y) é a casa de saida. 
saida(X,Y):- X = 4, Y = 3, h(esta(X,Y),S).

%Se há a percepção brisa ao mover em S e estou em (X,Y) em S a casa para onde tentou mover é uma casa não segura pois pode conter o buraco
%A brisa é causada por tentar ir para uma casa não segura
h(casa_Nsegura(X,Y1),r(mover(cima),S)):- h(estar(X,Y),S),
				Y1 is Y+1, mundo(_,My),
				Y1=<My,
				h(brisa,r(mover(cima),S)).

h(casa_Nsegura(X1,Y),r(mover(direita),S)):- h(estar(X,Y),S),
				X1 is X+1, mundo(Mx,_),
				X1=<Mx,
				h(brisa,r(mover(direita),S)).

h(casa_Nsegura(X,Y1),r(mover(baixo),S)):- h(estar(X,Y),S),
				Y1 is Y-1, Y1 >0,
				h(brisa,r(mover(baixo),S)).

h(casa_Nsegura(X1,Y),r(mover(esquerda),S)):- h(estar(X,Y),S),
				X1 is X-1, X1>0,
				h(brisa,r(mover(esquerda),S)).

%casa_segura - não é uma condição primitiva
%uma casa é segura se quando o agente se moveu para lá não sentiu brisa nem tiver buraco

%casa_segura(X,Y):- h(estar(X,Y),S), val1(X,Y,K,W,P), \+h(brisa,r(move(P),S)), \+buraco(K,W).



%val - auxiliar para calcular as posições de acordo com os movimentos

val(X,W,X,Y,cima):- W is Y+1, mundo(_,My), W=<My.
val(X,W,X,Y,baixo):- W is Y-1, W>0.

val(K,Y,X,Y,esq):- K is X-1, K>0.
val(K,Y,X,Y,dir):- K is X+1, mundo(Mx,_), K=<Mx.


val1(X,W,X,Y,cima):- Y is W-1, Y>0.
val1(X,W,X,Y,baixo):- Y is W+1, mundo(_,My), Y=<My.
val1(K,Y,X,Y,esq):- X is K+1, mundo(Mx,_), X=<Mx.
val1(K,Y,X,Y,dir):- X is K-1, X>0.


%mais_perto - Se é mais perto ir de S1 para C do que de S para C
mais_perto(C,S,S1):- caminho(C,S,N), caminho(C,S1,M),!, M<N.


%comprimento do caminho onde está em S para a casa C
caminho((C,D),S,N):- resulta(S1,S,0,20,N),
h(estar(C,D),S1),\+ casa_Nsegura(C,D).

%distancia entre a situação S1 e S
resulta(_,_,M,M,_):-!,fail.
resulta(S1,S,I,_,I):- resulta(S1,S,I).
resulta(S1,S,I,M,N):- J is I+1, resulta(S1,S,J,M,N).

resulta(S,S,0).
resulta(r(_,S1),S,N):- N>0, M is N-1, resulta(S1,S,M).
