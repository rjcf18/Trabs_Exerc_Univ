%Descricao do problema:

%estado_inicial(Estado)
%estado_final(Estado)

%representacao dos operadores
%op(Eact,OP,Eseg,Custo)

%representacao dos nos
%no(Estado,no_pai,Operador,Custo,H+C,Profundidade)

pesquisa(Problema,Alg):-
  consult(Problema),
  estado_inicial(S0),
  assertz(nev(0)),
  assertz(nmem(0)),
  pesquisa(Alg,[no(S0,[],[],0,1,0)],Solucao),
  escreve_seq_solucao(Solucao),
  retract(nev(_)),
  retract(nmem(_)).


pesquisa(a,E,S):- pesquisa_a(E,S,0).

%pesquisa_a([],_):- !,fail.
pesquisa_a([no(E,Pai,Op,C,HC,P)|_],no(E,Pai,Op,C,HC,P),Expand):- 
    %write(a(HC,P,E)),nl, read(X),
	nev(X),
	Y is X+1, 
	retract(nev(X)), 
	assertz(nev(Y)),
	estado_final(E),write('Expande: '),write(Expand),write('\n').

pesquisa_a([E|R],Sol,Expand):- expande(E,Lseg), esc(E),
                              insere_ord(Lseg,R,Resto),
	listSize(Resto,X),
	nmem(Y),
	bigger(X,Y,Z),
	retract(nmem(Y)),
	assertz(nmem(Z)),
                              NE is Expand+1,
                              pesquisa_a(Resto,Sol,NE).

expande(no(E,Pai,Op,C,HC,P),L):- findall(no(En,
                                                            no(E,Pai,Op,C,HC,P),Opn,Cnn,HCnn,P1),
                                    (op(E,Opn,En,Cn),P1 is P+1, Cnn is Cn+C, h(En,H), 
                                                                                          HCnn is Cnn+H), L).



insere_ord([],L,L).
insere_ord([A|L],L1,L2):- insereE_ord(A,L1,L3), insere_ord(L,L3,L2).

insereE_ord(A,[],[A]).
insereE_ord(A,[A1|L],[A,A1|L]):- menor_no(A,A1),!.
insereE_ord(A,[A1|L], [A1|R]):- insereE_ord(A,L,R).

menor_no(no(_,_,_,_,N,_), no(_,_,_,_,N1,_)):- N < N1.

escreve_seq_solucao(no(E,Pai,Op,Custo,_HC,Prof)):- write(custo(Custo)),nl,
                                        write(profundidade(Prof)),nl,
                                        escreve_seq_accoes(no(E,Pai,Op,_,_,_)),
					write('Num. de nos visitados: '),
					nev(X),
					write(X),
					nl,
					write('Num. maximo de nos em memoria: '),
					nmem(Y),
					write(Y).


escreve_seq_accoes([]).
escreve_seq_accoes(no(E,Pai,Op,_,_,_)):- escreve_seq_accoes(Pai),
                                              write(e(Op,E)),nl.

esc(A):- write(A), nl.

listSize([],0).
listSize([_|T],S1):- listSize(T,S2), S1 is S2+1.

listMin([H|L], Min) :-
    listMin(L, H, Min).

listMin([], Min, Min).

listMin([H|L], Min1, Min) :-
    Min2 is min(H, Min1),
    listMin(L, Min2, Min).

bigger(X,X,Z):-
	Z = X.
bigger(X,Y,Z):-
	X > Y,
	Z = X.

bigger(X,Y,Z):-
	Y > X,
	Z = Y.
