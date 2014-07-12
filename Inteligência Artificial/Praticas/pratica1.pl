homem('Afonso Henriques','rei de Portugal',1109).
homem('Henrique de Borgonha','conde de Portugal',1069).

homem('Sancho I','rei de Portugal',1154).
homem('Fernando II','rei de Leão',1137).
homem('Afonso IX', 'rei de Leão e Castela', 1171).
homem('Afonso II', 'rei de Portugal',1185).

homem('Sancho II', 'rei de Portugal',1207).
homem('Afonso III', 'rei de Portugal',1210).


mulher('Teresa de Castela', 'condessa de Portugal', 1080).
mulher('Mafalda', 'condessa de Saboia', 1125).
mulher('Urraca', 'infanta de Portugal',1151).
mulher('Dulce de Barcelona','infanta de Aragão',1160).
mulher('Berengeria', 'infanta de Portugal',1194).
mulher('Urraca C','infanta de Castela',1186).


filho('Afonso Henriques','Henrique de Borgonha').
filho('Afonso Henriques','Teresa de Castela').
filho('Urraca','Afonso Henriques').
filho('Sancho I','Afonso Henriques').
filho('Urraca','Mafalda').
filho('Sancho I','Mafalda').
filho('Afonso IX','Urraca').
filho('Afonso IX','Fernando II').
filho('Afonso II','Sancho I').
filho('Afonso II','Dulce de Barcelona').
filho('Berengeria','Sancho I').
filho('Berengeria','Dulce de Barcelona').
filho('Sancho II','Afonso II').
filho('Afonso III','Afonso II').
filho('Sancho II','Urraca C').
filho('Afonso III','Urraca C').
filho('Sancho II','Afonso II').
filho('Afonso III','Afonso II').
filho('Sancho II','Urraca C').
filho('Afonso III','Urraca C').

irmao(n1, n2):-
	n1 \== n2,
	homem(X,_,_),

	filho(n1,X),
	filho(n2,X).

irmao(n1, n2):-
	n1 \== n2,
	mulher(Y,_,_),

	filho(n1,Y),
	filho(n2,Y).

irmao(n1, n2):-
	n1 \== n2,
	homem(X,_,_),
	mulher(Y,_,_),

	filho(n1,X),
	filho(n1,Y),
	filho(n2,X),
	filho(n2,Y).	

primoDireito(n1, n2):-
	filho(n1, X),
	filho(n2, Y),
	irmao(X,Y).

irmaos(n1, L):-
	findall(I, irmao(n1, I), L).

%filhosPrimos([], L, L):-

primos(n1, L):-
	findall(I, primoDireito(n1, I), L).	


