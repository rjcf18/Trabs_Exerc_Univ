 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Predicates for the management of the temporaries (integers and floats) and labels counters %%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% fetches the current temporary or label given the type and increments it
get_counter(T, int):-temps(T), increase_t.
get_counter(T, real):-fptemps(T), increase_f.
get_counter(T, bool):-temps(T),increase_t.
get_counter(L, label):-labels(L), increase_l.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% increments the current temporary or label number
increase_t:-
    temps(T),
    Tn is T+1,
    retractall(temps(_)), 
    asserta(temps(Tn)).

increase_f:-
    fptemps(F),
    Fn is F+1,
    retractall(fptemps(_)),
    asserta(fptemps(Fn)).

increase_l:-
    labels(L),
    Ln is L+1,
    retractall(labels(_)),
    asserta(labels(Ln)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% resets the counters for temporaries (int and float) and for labels
reset_counters:-
    retractall(temps(_)),
    retractall(fptemps(_)),
    retractall(labels(_)),
    asserta(temps(0)),
    asserta(fptemps(0)),
    asserta(labels(0)).
    
