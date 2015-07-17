% Para descrever um problema deve descrever:

% estado_inicial([Condicoes])

% estado_final ([Condicoes]).

% e declarar as accoes que permitem modelar o seu problema com o seguinte predicado:

% accao(a1,Precond,AddList,DeleteList).

%/* Exemplo para o problema: blocos a, b, c */

accao(move_chao(A),[livre(A), sobre(A,B)], [chao(A), livre(B),livre(A)], [sobre(A,B)]):- member(A,[a,b,c]), member(B,[a,b,c]), A\= B.

accao(move(A,B),[livre(A), livre(B),chao(A)], [sobre(A,B), livre(A)], [livre(B), chao(A)]):- member(A,[a,b,c]), member(B,[a,b,c]), A\= B.

accao(move(A,B),[livre(A), livre(B),sobre(A,C)], [sobre(A,B), livre(A), livre(C)], [livre(B),  sobre(A,C)]):- member(A,[a,b,c]), member(B,[a,b,c]), A\= B,member(C,[a,b,c]), A\=C, B\=C.

estado_final([chao(a),chao(c), sobre(b,c), livre(b), livre(a)]).

%estado_final([chao(c), livre(a), sobre(b,c),sobre(a,b)]).

estado_inicial([chao(a),chao(c), sobre(b,a), livre(b), livre(c)]).

/* Exemplo para o problema: Calcar sapatos e meias


accao(calcarSapato(Pe),[meia(Pe)],[sapato(Pe)],[]).
accao(calcarMeia(Pe),[],[meia(Pe)],[]).

estado_inicial( []).

estado_final( [sapato(esq),sapato(dir)]).

*/
% Exemplo para o problema de ir as compras (esta descrito no livro): 
% Problema das Compras

/*
accao(go(X,Y),[at(X)], [at(Y)],[at(X)]):- (X=super;X=hws;X=home),
(Y=super;Y=hws;Y=home),
X\=Y.

accao(buy(X),[sell(L,X),at(L)],[have(X)],[]):- estado_inicial(Li),
member(sell(L,X),Li).

estado_inicial([at(home),sell(super,banana),sell(hws,drill),sell(super,milk)]).

estado_final([have(milk),have(drill),have(banana),at(home)]).

*/
