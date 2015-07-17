aula(disciplina(112, 'PD'),docente('Vitor','Nogueira','Informatica'),horario('Seg',16,18),local('CLAV',140)).

localizacao(Disc,Predio,Sala):-
	aula(disciplina(_,Disc),_,_,local(Predio,Sala)).

indisponivel(Docente, DiaSem, HoraInic, HoraFinal):-
	aula(_,docente(Docente,_,_),horario(DiaSem,HoraInic,HoraFinal),_).

obtem_docente(Docente):-
	aula(_,docente(Docente,_,_),_,_).

obtem_departamento(Departamento):-
	aula(_,docente(_,_,Departamento),_,_).