%###############Alfabeta - com corte############

% decide qual é a melhor jogada num estado do jogo
% alfabeta_decidir(Estado, MelhorJogada)

% se é estado terminal não há jogada 
alfabeta_decidir(Ei,terminou):- terminal(Ei).

%Para cada estado sucessor de Ei calcula o valor alfabeta do estado
%Opf é o operador (jogada) que tem maior valor

alfabeta_decidir(Ei,Opf):- 
	findall(Es-Op, op1(Ei,Op,Es),L),
	length(L, S),
	incMais(S),
	incProf,
	findall(Vc-Op,(member(E-Op,L), alfabeta_valor(E,Vc,2000,-2000)),L1),
	escolhe_max(L1,Opf).

% se um estado é terminal o valor é dado pela função de utilidade
alfabeta_valor(Ei,Val,_,_):- terminal(Ei), !, valor(Ei,Val,_).

%Se o estado não é terminal o valor é:
% -se a profundidade é par, o maior valor dos sucessores de Ei
% -se aprofundidade é impar o menor valor dos sucessores de Ei
alfabeta_valor(Ei,Val,Alfa,Beta):- 
	findall(Es,op1(Ei,_,Es),L),
	length(L, S),
	incMais(S),
	incProf,
	corte_min(L,Alfa,Beta,Val,[]).

min_valor(Ei,Val,_,_):- terminal(Ei),!,valor(Ei,Val,_).

min_valor(Ei,Val,_,_):- 
	p(P), 
	prof(Lim),
	P>=Lim,
	func_aval(Ei,Val,_),!.

min_valor(Ei,Val,Alfa,Beta):- 
	findall(Es,op1(Ei,_,Es),L),
	length(L,M),
	incMais(M),
	corte_max(L,Alfa,Beta,Val,[]).

corte_max([],_,_,Max,Vals):-
	maximo1(Vals,Max).

corte_max(_,Alfa,_,Val,[Val|_]):-
	Val>=Alfa,!.

corte_max([E|Es],Alfa,_,V,Vs):-
	maximo1(Vs,NovoBeta),
	alfabeta_valor(E,Val,Alfa,NovoBeta),	
	corte_max(Es,Alfa,NovoBeta,V,[Val|Vs]).

corte_min([],_,_,Min,Vals):-
	minimo1(Vals,Min).

corte_min(_,_,Beta,Val,[Val|_]):-
	Val=<Beta,!.

corte_min([E|Es],_,Beta,V,Vs):-
	minimo1(Vs,NovoAlfa),
	min_valor(E,Val,NovoAlfa,Beta),
	corte_min(Es,NovoAlfa,Beta,V,[Val|Vs]).

maximo1([],-2000).
maximo1([A|R],Val):- maximo1(R,A,Val).

maximo1([],A,A).
maximo1([A|R],X,Val):- A < X,!, maximo1(R,X,Val).
maximo1([A|R],_,Val):-  maximo1(R,A,Val).


escolhe_max([A|R],Val):- escolhe_max(R,A,Val).
 
escolhe_max([],_-Op,Op). 
escolhe_max([A-_|R],X-Op,Val):- A < X,!, escolhe_max(R,X-Op,Val). 
escolhe_max([A|R],_,Val):-  escolhe_max(R,A,Val). 
 
minimo1([],2000). 
minimo1([A|R],Val):- minimo1(R,A,Val). 
 
minimo1([],A,A). 
minimo1([A|R],X,Val):- A > X,!, minimo1(R,X,Val). 
minimo1([A|R],_,Val):-  minimo1(R,A,Val).

