aula(1,33,11,22).
disciplina(1,'pd').
docente(33,'vb','n',44).
departamento(44,'Inf').
horario(11,'Seg',16,18).
local(22,7,140).
predio(7,'clav').

localizacao(Disc, Predio, Sala):-
	disciplina(CodD, Disc),
	aula(CodD,_,_,CodL),
	local(CodL, CodP, Sala),
	predio(CodP, Predio).

indisponivel(Doc,DiaSem,HoraIn,HoraFim):-
	docente(CodD, Doc,_,_),
	aula(_,CodD,CodH,_),
	horario(CodH,DiaSem,HoraIn,HoraFim).

obtem_docente(Doc):-
	docente(_,Doc,_,_).

obtem_departamento(Dep):-
	departamento(_,Dep).

