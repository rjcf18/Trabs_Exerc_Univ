%estado_inicial((turistas em terra, turistas no barco, turistas
% terminaram viagem)

estado_inicial(([12,28,34,36,45,57,65,78,98,120],[])).

%estado_final
estado_final(([],[12,28,34,36,45,57,65,78,98,120])).

op( (X,Y), transporta(Y2), (X1,Y1), 1) :- p(X,L), mais_t(L,[Y2,X1]), append(Y,Y2,Y1).
%op( (X,Y,Z), desembarca, (X,[],Z2),1):- append(Y,Z,Z1),sort(Z1,Z2).

%embarcar([],X,[],X):- X=<140.
% embarcar([L1|L],Y,L2,Y1) :- append(L1,Y,Y2), soma(Y2,S), S=<140,
% embarcar(L,Y2,_,Y3), append(Y2,Y3,Y1).
%embarcar([L1|L],Y,L,[L1|Y]) :- soma([L1|Y],S), S=<140.


%soma([],0).
%soma([L1|L],N) :- soma(L,N1), N is N1+L1.

%tira1([E|L], [E], L).

%tira1([E1|L], N, [E1|L1]):- tira1(L,N,L1).

%permutar([],[]).

%permutar(L,[X|L1]):- member1(X,L,L0), permutar(L0,L1).

%member1(X,[X|L],L).

%member1(X,[A|L],[A|L1]):- member1(X,L,L1).

%t(A,L):- permutar(L,R), append(A,B,R), soma(A,S), S=<140.


h((X,Y),V):-
	length(X, Lx), length(Y, Ly), V is Ly - Lx.

%retira(X,L,L1)

retira(X,[X|R],R).
retira(X,[A|R],[A|S]) :- retira(X,R,S).

%retiraN

retiraN(R,R,L,L):-R\=[].
retiraN(R,R1,L,L1):- retira(X,L,L11), soma(R,X,140), retiraN([X|R], R1,L11,L1).

soma([],Y,K):- !, Y< K.
soma([X|R],Y,K):- Y1 is Y+X, Y1 <K, soma(R,Y1,K).


%retiraN([],X,[28,65,45,57,98,120,34,12,36,78],L).

%todas as particoes sem repetidos

p(Li,K1):-
	findall([X1,L1],(retiraN([],X,Li,L),sort(X,X1),sort(L,L1)),K),sort(K,K1).

mais_t([[L,L1]],[L,L1]).
mais_t([H|T],M):-
	mais_turistas(T,H,M).

mais_turistas([],[L,L1],[L,L1]).
mais_turistas([[L,L1]|Ls],[X,Xs],M):- length(L,N),length(X,Nx), Nx>=N,!, mais_turistas(Ls,[X,Xs],M).
mais_turistas([[L,L1]|Ls],[X,Xs],M):- length(L,N),length(X,Nx), Nx=<N, mais_turistas(Ls,[L,L1],M).

















