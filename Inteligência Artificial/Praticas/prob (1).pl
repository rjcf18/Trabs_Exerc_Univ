tamanho_tabuleiro(4).
estado_inicial(E):-
	functor(E, e, 2), arg(1, E, T), arg(2, E, []),
	tamanho_tabuleiro(S),
        gerar_tab(T2, S),
	flatten(T2, T).

gerar_tab(L, Size):- 
	gerar_tab(L, 1, Size).
gerar_tab([H], N, N):-
	gerar_coluna(H, N, N).
gerar_tab([H|T], J, N):-
	J < N, J2 is J+1,
	gerar_coluna(H, J, N),
	gerar_tab(T, J2, N).
	
gerar_coluna(L, J, NColunas):- 
	gerar_coluna(L, 1, J, NColunas).
gerar_coluna([H], N, J, N):-
	H = v(p(N, J), [0,1], _).
gerar_coluna([H|T], I, J, N):-
	I < N, I2 is I+1,
	H = v(p(I, J), [0,1], _),
	gerar_coluna(T, I2, J, N).

ve_restricoes(e(_NAssign, Assigned)):-
	ver_linha(Assigned), ver_colunas(Assigned).

% ------------------------------------------------
ver_colunas(L):-
	tamanho_tabuleiro(S),
        ver_colunas(L, 1, S).
ver_colunas(L, S, S):-
	ver_coluna(L, J).
ver_colunas(L, J, S):-
        J < S,
        ver_coluna(L, J),
	J2 is J+1,
	ver_colunas(L, J2).
% ------------------------------------------------
ver_linhas(L):-
	tamanho_tabuleiro(S),
	ver_linhas(L, 1, S).
ver_linhas(L, S, S):-
	ver_linha(L, I).
ver_linhas(L, I, S):-
	I < S,
	ver_linha(L, I),
	I2 is I+1,
	ver_linhas(L, I2, S).

% ------------------------------------------------
% I (Linha) J (Coluna)
ver_linha(L, I):-
	ver_linha(L, I, 1, 0).

ver_linha(L, I, J, N):-
	tamanho_tabuleiro(T), J=T, 
	member(v(p(I, J), _, X), L),
	increment(X, N, N2).

ver_linha(L, I, J, N):-
	tamanho_tabuleiro(T), J=T, 
        \+member(v(p(I, J), _, X), L).

ver_linha(L, I, J, N):-
	tamanho_tabuleiro(T), J<T ,J2 is J+1, 
	member(v(p(I, J), _, X), L),
	increment(X, N, N2),
	ver_linha(L, I, J2, N2).

ver_linha(L, I, J, N):-
	tamanho_tabuleiro(T), J<T ,J2 is J+1, 
        \+ member(v(p(I, J), _, X), L),
        ver_linha(L, I, J2, 0).

% ------------------------------------------------
% I (Linha) J (Coluna)
ver_coluna(L, J):-
        ver_coluna(L, 1, J, 0).

ver_coluna([H], I, J, N):-
        member(v(p(I, J), _, X), [H]),
        increment(X, N, N2).

ver_coluna([H|T], I, J, N):-
        I2 is I+1,
        member(v(p(I, J), _, X), [H]),
        increment(X, N, N2),
        ver_coluna(T, I2, J, N2).
% ------------------------------------------------
increment(X, N, N2):-
	X = 1, N2 is N+1,
	N2 < 3.
increment(X, N, N2):-
	X = 0, N2 = 0.
	

