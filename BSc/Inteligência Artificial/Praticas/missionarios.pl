%transportar missionarios e canibais
transporte (2, missio_Canibal).

% o 0 é a margem em que esta o barco
%op(Estado_act, Operador, Estado_seg, Custo)
op((A, B, 0), e(c1), (A1, B, 1), 1):-		%0->margem em k esta o barco..A1-> muda miss mantem = cani..1-> ida para a outra margem                    
	transporte(c1, C, missionario),
	A1 is A-C,
	B <= A1.                                       

op((A, B, 1), e(c2), (A1, B, 0), 1):-
	tranporte(c2, C, missionario),
	A1 is A-C,
	B <= A1.

op((A, B), d(c1), (0, B), 1):- 				
	A\= 0. 						

op((A, B), d(c2), (A ,0), 1):-
	B \= 0.

op((A, B), d(c1, c2), (A2, B3), 1):-			
	capacidade(c2, B1),
	B2 is A+B,
	min(B3, B1, B2),
	A2 is B2 - B3,					
	A \= A2,
	B \= B3.

op((B, A), d(c2, c1), (B3, A2), 1):-
	capacidade(c1, B1),
	B2 is A+B,
	min(B3, B1, B2),
	A2 is B2 - B3,
	A \= A2,
	B \= B3.


max(A, A, B):-
	A > B,
	!.
max(A,_,A).


min(A, A, B):-
	A < B,
	!.
min(A, _, A).