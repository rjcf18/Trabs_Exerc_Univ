cima(0,1).
cima(1,2).
cima(2,3).

%estado inicial - 0
estado_inicial([mao([]), contem(1,a), contem(2,b), contem(3,c), fechada(1), fechada(2), fechada(3), fechada(0)] ).

%estado final - 2
estado_final([contem(3,a), contem(2,b), contem(3,c), fechada(1), fechada(2), fechada(3)]). 

%##############################################################################################################%

% accao(a1,Precond,AddList,DeleteList).

%fechar gaveta G
accao(fechaGaveta(G),[aberta(G)],[fechada(G)],[aberta(G)]) :- member(G,[1,2,3]).

%abrir gaveta G
accao(abreGaveta(G),[mao([]), fechada(G)],[aberta(G)],[fechada(G)]) :- member(G,[1,2,3]).

accao(colocaObjecto(G,O), [mao(O), aberta(G), fechada(G1)], [contem(G,O), mao([])], [mao(O)]):- cima(G1,G), member(O, [a,b,c]).

accao(tiraObjecto(G,O), [mao([]), aberta(G), contem(G,O), fechada(G1)], [mao(O)], [contem(G,O), mao([])]):- cima(G1,G), member(O, [a,b,c]).



% Plano = [s1-inicial,s243-abreGaveta(1),s244-abreGaveta(3),s242-tiraObjecto(1,a),s241-colocaObjecto(3,a),s245-fechaGaveta(1),s246-fechaGaveta(3),s2-final]
