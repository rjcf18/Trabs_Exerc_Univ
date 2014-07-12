%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pesquisas

%Descricao do problema:

%estado_inicial(Estado)
%estado_final(Estado)

%representacao dos operadores
%op(Eact,OP,Eseg,Custo)

%representacao dos nos
%no(Estado,no_pai,OperadorCusto,Profundidade)

pesquisa(Problema,Alg):-
  consult(Problema),
  estado_inicial(S0),
  assertz(nev(0)),
  assertz(nmem(0)),
  pesquisa(Alg,[no(S0,[],[],0,0)],Solucao),
  escreve_seq_solucao(Solucao),
  retract(nev(_)),
  retract(nmem(_)).

pesquisa(it,Ln,Sol):- pesquisa_it(Ln,Sol,1).
pesquisa(largura,Ln,Sol):- pesquisa_largura(Ln,Sol).
pesquisa(profundidade,Ln,Sol):-
	pesquisa_profundidade(Ln,Sol).

%pesquisa_profundidade iterativa
pesquisa_it(Ln,Sol,P):- pesquisa_pLim(Ln,Sol,P).
pesquisa_it(Ln,Sol,P):- P1 is P+1, pesquisa_it(Ln,Sol,P1).

%pesquisa_profundidade
pesquisa_profundidade([no(E, Pai, Op, C, P)|_], no(E, Pai, Op, C, P)):-
	nev(X),
	Y is X+1, 
	retract(nev(X)), 
	assertz(nev(Y)),	
	estado_final(E).

pesquisa_profundidade([E|R], Sol):-
	expande(E, Lseg), 
	esc(E),
	insere_inicio(Lseg, R, Resto),
	listSize(Resto,X),
	nmem(Y),
	bigger(X,Y,Z),
	retract(nmem(Y)),
	assertz(nmem(Z)),
	pesquisa_profundidade(Resto, Sol).

%pesquisa_largura([],_):- !,fail.
pesquisa_largura([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P)):- 
	nev(X),
	Y is X+1, 
	retract(nev(X)), 
	assertz(nev(Y)),
	estado_final(E).

pesquisa_largura([E|R],Sol):- expande(E,Lseg),
			      esc(E),
                              insere_fim(Lseg,R,Resto),
			      listSize(Resto,X),
			      nmem(Y),
			      bigger(X,Y,Z),
			      retract(nmem(Y)),
			      assertz(nmem(Z)),
                              pesquisa_largura(Resto,Sol).

expande(no(E,Pai,Op,C,P),L):- findall(no(En,no(E,Pai,Op,C,P),Opn,Cnn,P1),
                                    (op(E,Opn,En,Cn),P1 is P+1, Cnn is Cn+C),
                                    L).


expandePl(no(E,Pai,Op,C,P),[],Pl):- Pl =< P, ! .
expandePl(no(E,Pai,Op,C,P),L,_):- findall(no(En,no(E,Pai,Op,C,P),Opn,Cnn,P1),
                                    (op(E,Opn,En,Cn),P1 is P+1, Cnn is Cn+C),
                                    L).
insere_fim([],L,L).
insere_fim(L,[],L).
insere_fim(R,[A|S],[A|L]):- insere_fim(R,S,L).

insere_inicio([], L, L).
insere_inicio(L, [], L).
insere_inicio(R, T, L):-append(R,T,L).

pesquisa_pLim([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P),_):- 
	nev(X),
	Y is X+1, 
	retract(nev(X)), 
	assertz(nev(Y)),	
	estado_final(E).

pesquisa_pLim([E|R],Sol,Pl):- expandePl(E,Lseg,Pl), esc(E),
                              insere_fim(R,Lseg,Resto),
			      listSize(Resto,X),
			      nmem(Y),
			      bigger(X,Y,Z),
			      retract(nmem(Y)),
			      assertz(nmem(Z)), 
                              pesquisa_pLim(Resto,Sol,Pl).


escreve_seq_solucao(no(E,Pai,Op,Custo,Prof)):- 
	write(custo(Custo)),
	nl,
        write(profundidade(Prof)),
	nl,
	escreve_seq_accoes(no(E,Pai,Op,_,_)),
	write('Num. de nos visitados: '),
	nev(X),
	write(X),
	nl,
	write('Num. maximo de nos em memoria: '),
	nmem(Y),
	write(Y).


escreve_seq_accoes([]).
escreve_seq_accoes(no(E,Pai,Op,_,_)):- 
	escreve_seq_accoes(Pai),
	write(e(Op,E)),
	nl.

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
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
