tamanho(0, []).

tamanho(N,[_|R]):-
    tamanho(M,R),
    N is M+1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

soma([], 0).
soma([H|Lista], SomaDaLista):-
	soma(Lista, Soma),
	SomaDaLista is Soma+H.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

double_list([],[]).
double_list([H1|T1],[H2|T2]):-
	H2 is H1 +H1,	
	double_list(T1,T2).

%%%%%%%%%%%%%%%%%%%%%%%

nth_el(1,[X|_],X).
nth_el(N,[_|L],X):-
	nth_el(N1,L,X),
	N is N1 + 1.

%%%%%%%%%%%%%%%%%%%%%%%

is_binary_tree(leaf).
is_binary_tree(tree(Left,_,Right)):-
	is_binary_tree(Left) 	,
	is_binary_tree(Right).

btree(1,tree(leaf,a,leaf)).
btree(2,leaf).

%%%%%%%%%%%%%%%%%%%%%%%

substitui(_, _, [], []).
substitui(N1, N2, [N1|R], [N2|R2]):- 
	substitui(N1, N2, R, R2).
substitui(N1, N2, [H|R], [H|R2]):-
	H \= N1, 
	substitui(N1, N2, R, R2).

%%%%%%%%%%%%%%%%%%%%%%%

