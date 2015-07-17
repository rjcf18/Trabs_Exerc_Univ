estado_inicial(20).

terminal(31).

%função de utilidade, retorna o valor dos estados terminais, 1 ganha -1 perde
valor(31,1,P):- X is P mod 2, X=0,!.
valor(31,-1,_).


% op1(estado,jogada,estado seguinte)
op1(X,mais_1,Y):- Y is X+1, Y=<31.
op1(X,mais_2,Y):- Y is X+2, Y=<31.
op1(X,mais_3,Y):- Y is X+3, Y=<31.