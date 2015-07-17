nth1(1, [Head|_], Head) :- !.

nth1(N, [_|Tail], Elem) :-
    nonvar(N),
    M is N-1,           % should be succ(M, N)
    nth1(M, Tail, Elem).

nth1(N,[_|T],Item) :-       % Clause added KJ 4-5-87 to allow mode
    var(N),         % nth1(-,+,+)
    nth1(M,T,Item),
    N is M + 1.

tamanho(9).
% c(X) - coluna X, L - dominio para a linha
estado_inicial(e(L,[])):- lista(List), 
    findall(v(p(X,_),List,_Valor),member(X,List),L),
    findall(v(p(_,Y),List,_Valor),member(Y,List),L).
 
 
% lista que corresponde ao dominio, e caracteriza a rainha
lista(L):- lista(1,L).
lista(P,[P|R]):- tamanho(N),
    P=<N,!,
    P1 is P+1,
    lista(P1,R).
lista(_P,[]).
 
 
restricoes(e(Nafect,Afect)):-  
    \+ (member(v(c(I),Di,Vi),Afect), 
    member(v(c(J),Dj,Vj),Afect),
    I\=J, % colunas diferentes
    (Vi=Vj;diag(I,J,D1),diag(Vi,Vj,D2),D1=D2)). % diagonais diferentes
 
diag(I,J,D):- I<J,!, D is J-I.
diag(I,J,D):- D is I-J.
