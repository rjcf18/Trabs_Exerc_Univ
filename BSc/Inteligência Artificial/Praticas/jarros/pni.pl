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
  pesquisa(Alg,[no(S0,[],[],0,0)],Solucao),
  escreve_seq_solucao(Solucao).




pesquisa_it(Ln,Sol,P):- pesquisa_pLim(Ln,Sol,P).
pesquisa_it(Ln,Sol,P):- P1 is P+1, pesquisa_it(Ln,Sol,P1).
pesquisa(it,Ln,Sol):- pesquisa_it(Ln,Sol,1).
pesquisa(largura,Ln,Sol):- pesquisa_largura(Ln,Sol,0).



%pesquisa_largura([],_):- !,fail.
pesquisa_largura([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P),Expand):- estado_final(E),write('Expande: '),write(Expand),write('\n').

pesquisa_largura([E|R],Sol,Expand):- expande(E,Lseg), esc(E),
                              insere_fim(Lseg,R,Resto),
                              NE is Expand+1,
                              pesquisa_largura(Resto,Sol,NE).

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

pesquisa_pLim([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P),_):- estado_final(E).

pesquisa_pLim([E|R],Sol,Pl):- expandePl(E,Lseg,Pl), esc(E),
                              insere_fim(R,Lseg,Resto), 
                              pesquisa_pLim(Resto,Sol,Pl).


escreve_seq_solucao(no(E,Pai,Op,Custo,Prof)):- write(custo(Custo)),nl,
                                          write(profundidade(Prof)),nl,
                                          escreve_seq_accoes(no(E,Pai,Op,_,_)).


escreve_seq_accoes([]).
escreve_seq_accoes(no(E,Pai,Op,_,_)):- escreve_seq_accoes(Pai),
                                              write(e(Op,E)),nl.

esc(A):- write(A), nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
