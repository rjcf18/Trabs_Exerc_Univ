 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Generation of the IR and calling the IR printer given the different nodes %%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VAR DECLARATION
gen_ir(var(Destination, Origin): _, _):-
    gen_ir(Destination, _),
    gen_ir(Origin, _).

gen_ir(var(Destination, Origin), _):-
    Destination = id(_, _, Type),
    gen_ir(Origin, ROrigin),
    print_ir(var, Type, [ Destination, ROrigin]).

gen_ir(var(_, nil), _).
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Literals
    
% Int 
gen_ir(int_literal(Value): int, term(literal,( T, TYPE), Value)):-
    temps(T),increase_t,
    print_ir(literal, int, term(literal,( T, TYPE), Value)).

% Real 
gen_ir(real_literal(Value): real, term(literal,( T, TYPE), Value)):-
    fptemps(T), increase_f,
    print_ir(literal, real, term(literal,( T, TYPE), Value)).

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IDs

gen_ir(id(ID, KIND, TYPE): TYPE, term((ID, KIND), (T, TYPE), _)):-
    get_counter(T, TYPE),
    print_ir(id, (TYPE, load), term((ID, KIND),( T, TYPE), _)).

% ID
gen_ir(id(_, _, _), _).

gen_ir(true:bool, Temp):-
    get_counter(T, bool),Temp = term(literal, (T, int), 1),
    print_ir(literal, int, Temp).

gen_ir(false:bool, Temp):-
    get_counter(T, bool),Temp = term(literal, (T, int), 0),
    print_ir(literal, int, Temp).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%% Expressions

%%%%%%%
% Plus
gen_ir(plus(Term1, Term2): TYPE, term(temporary,( T, TYPE), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2),
    get_counter(T, TYPE),
    append([R1], [R2], List),
    append(List, [term(temporary, (T, TYPE), none)], List2),
    print_ir(plus, TYPE, List2).

%%%%%%%
% Minus
gen_ir(minus(Term1, Term2): TYPE, term(temporary,( T, TYPE), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2),
    get_counter(T, TYPE),
    append([R1], [R2], List),
    append(List, [term(temporary, (T, TYPE), none)], List2),
    print_ir(minus, TYPE, List2).

%%%%%%%
% Times
gen_ir(times(Term1, Term2): TYPE, term(temporary,( T, TYPE), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2),
    get_counter(T, TYPE),
    append([R1], [R2], List),
    append(List, [term(temporary, (T, TYPE), none)], List2),
    print_ir(times, TYPE, List2).

%%%%%%%
% Div
gen_ir(div(Term1, Term2): TYPE, term(temporary,( T, TYPE), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2),
    get_counter(T, TYPE),
    append([R1], [R2], List),
    append(List, [term(temporary, (T, TYPE), none)], List2),
    print_ir(div, TYPE, List2).
    
    
%%%%%%%%%%%%%
% Comparisons
gen_ir(eq(Term1, Term2): bool, term(temporary,( T, int), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2), arg(2, Term1, TYPE),
    temps(T), increase_t,
    print_ir(eq, TYPE, [R1, R2, term(temporary, (T, int), none)]).

gen_ir(ne(Term1, Term2): bool, term(temporary,( T, int), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2),arg(2, Term1, TYPE),
    temps(T), increase_t,
    print_ir(ne, TYPE, [R1, R2, term(temporary, (T, int), none)]).

gen_ir(lt(Term1, Term2): bool, term(temporary,( T, int), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2), arg(2, Term1, TYPE),
    temps(T), increase_t,
    print_ir(lt, TYPE, [R1, R2, term(temporary, (T, int), none)]).

gen_ir(le(Term1, Term2): bool, term(temporary,( T, int), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2), arg(2, Term1, TYPE),
    temps(T), increase_t,
    print_ir(le, TYPE, [R1, R2, term(temporary, (T, int), none)]).

gen_ir(gt(Term1, Term2): bool, term(temporary,( T, int), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2), arg(2, Term1, TYPE),
    temps(T), increase_t,
    print_ir(lt, TYPE, [R2, R1, term(temporary, (T, int), none)]).

gen_ir(ge(Term1, Term2): bool, term(temporary,( T, int), none)):-
    gen_ir(Term1, R1),gen_ir(Term2, R2), arg(2, Term1, TYPE),
    temps(T), increase_t,
    print_ir(le, TYPE, [R2, R1, term(temporary, (T, int), none)]).

%%%%%%%%%%%%%%%%%%%%%%
% Logical Ops
gen_ir(or(Term1, Term2): bool, R1):-
    labels(L0),increase_l,
    labels(L1),increase_l,
    gen_ir(Term1, R1),
    write('\t'),write('cjump '),
    print_term(R1),write(', '),
    print_tmp_l(label, L1), write(', '),
    print_tmp_l(label, L0),nl,
    print_tmp_l(label, L0),write(':'),nl,
    gen_ir(Term2, R2),
    print_ir(copy, _, [R1, R2]),
    print_tmp_l(label, L1),write(':'),nl,!.

gen_ir(and(Term1, Term2): bool, R1):-
    labels(L0),increase_l,
    labels(L1),increase_l,
    gen_ir(Term1, R1),
    write('\t'),write('cjump '),print_term(R1),write(', '),print_tmp_l(label, L0), write(', '),print_tmp_l(label, L1),nl,
    print_tmp_l(label, L0),write(':'),nl,
    gen_ir(Term2, R2),
    print_ir(copy, _, [R1, R2]),
    print_tmp_l(label, L1),write(':'),nl,!.

gen_ir(not(Term1): bool, term(temporary,( T, int), none)):-
    gen_ir(Term1, R1),
    temps(T), increase_t,
    print_ir(not, unary, [R1, term(temporary, (T, int), none)]).
    
%%%%%%%%%%%%%%%%
% Real coercion
gen_ir(toreal(Term): real, Destination):-
    gen_ir(Term, Origin),get_counter(T, real), increase_t, Destination = term(_, (T, real), _),
    print_ir(toreal, _, [Destination, Origin]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%         Statements         %%%

%%%%%%%%
% Assign
gen_ir(assign(Destination, Origin), _):-
    Origin \= id(_,_):_,
    Destination = id(NAME, KIND, TYPE),
    RDestination = term((NAME, KIND), (_, TYPE),_),
    gen_ir(Origin, ROrigin),
    print_ir(assign, (TYPE, store), [ RDestination, ROrigin]).

gen_ir(assign(Destination, Origin), _):-
    Destination = id(Name, Kind, Type), RDestination = term((Name, Kind), (_, Type),_),
    gen_ir(Origin, Result),
    print_ir(assign, (Type,store), [ RDestination, Result]).

%%%%%%%%
% Print
gen_ir(print(Term), _):-
    gen_ir(Term, R),R = term(_, (_, Type), _),
    print_ir(print, Type, R).

%%%%%%%%%%%
% Symmetric
gen_ir(inv(Term), _):-
    gen_ir(Term, R), R = term(_, (_, Type), _),
    temps(T), increase_t, Destination = term(_, (T, Type),_),
    print_ir(inv, Type, [Destination, R]).

%%%%%%%%%%%%%%%%%%%%
% Call - Procedure
gen_ir(call(Name, ArgsList), _):-
    process_nodelist(ArgsList, ResultsList),
    print_ir(call_procedure, Name, ResultsList).
    
%%%%%%%%%%%%%%%%%%
% Call - Functions
gen_ir(call(Name, ArgsList):int, Destination):-
    process_nodelist(ArgsList, ResultsList),
    temps(T), increase_t, Destination = term(_, (T, int), _),
    append([Destination], ResultsList, List),
    print_ir(call_function, (Name, int), List).

gen_ir(call(Name, ArgsList):real, Destination):-
    process_nodelist(ArgsList, ResultsList),
    fptemps(T), increase_f, Destination = term(_, (T, real), _),
    append([Destination], ResultsList, List),
    print_ir(call_function, (Name, real), List).

gen_ir(call(Name, ArgsList):bool, Destination):-
    process_nodelist(ArgsList, ResultsList),
    temps(T), increase_t, Destination = term(_, (T, bool), _),
    append([Destination], ResultsList, List),
    print_ir(call_function, (Name, bool), List).

%%%%%%%%%%%%    
% While
gen_ir(while(E, Stmts), _):-
    labels(L0), increase_l,
    labels(L1), increase_l,
    labels(L2), increase_l,
    print_tmp_l(label, L0),write(':'),nl,
    gen_ir(E, _),
    print_tmp_l(label, L1),write(':'),nl,
    process_nodelist(Stmts, _),
    write('\t'),write('jump '), 
    print_tmp_l(label, L0),nl,
    print_tmp_l(label, L2),write(':'),nl.
    
%%%%%%%%%%%%%%%%%%%%%%%%
% If
gen_ir(if(E, S1, S2), _):-
    is_list(S1), is_list(S2),
    labels(IfLabel), increase_l,
    labels(ElseLabel), increase_l,
    labels(EndLabel), increase_l,
    gen_ir(E, Result), 
    Result = term(_,(TResult, TypeResult),_),
    write('\t'),write('cjump '),print_tmp_l(TypeResult, TResult),write(', '),
    print_tmp_l(label, IfLabel), write(', '),
    print_tmp_l(label, ElseLabel),nl,
    print_tmp_l(label, IfLabel),write(':'),nl,
    process_nodelist(S1, _),
    write('\t'),write('jump '),print_tmp_l(label, EndLabel),nl,
    print_tmp_l(label, ElseLabel),write(':'),nl,
    process_nodelist(S2, _),
    print_tmp_l(label, EndLabel),write(':'),nl.

gen_ir(if(E, S1, S2), _):-
    S2 \= nil,
    labels(IfLabel), increase_l,
    labels(ElseLabel), increase_l,
    labels(EndLabel), increase_l,
    gen_ir(E, Result), Result = term(_,(TResult, TypeResult),_),
    write('\t'),write('cjump '),print_tmp_l(TypeResult,TResult),write(', '),
    print_tmp_l(label, IfLabel), write(', '),
    print_tmp_l(label, ElseLabel),nl,
    print_tmp_l(label, IfLabel),write(':'),nl,
    gen_ir(S1, _),
    write('\t'),write('jump '), 
    print_tmp_l(label, EndLabel),nl,
    print_tmp_l(label, ElseLabel),write(':'),nl,
    gen_ir(S2, _),
    print_tmp_l(label,EndLabel), write(':'),nl.

gen_ir(if(E, Stmts, nil), _):-
    is_list(Stmts),
    labels(L0), increase_l,
    labels(L1), increase_l,
    gen_ir(E, Result),
    write('\t'),write('cjump '),
    print_term(Result),write(', '),
    print_tmp_l(label, L0), write(', '),
    print_tmp_l(label, L1),nl,
    print_tmp_l(label, L0),write(':'),nl,
    process_nodelist(Stmts, _),
    print_tmp_l(label, L1),write(':'),nl.

gen_ir(if(E, S1, nil), _):-
    labels(L0), increase_l,
    labels(L1), increase_l,
    gen_ir(E, Result),
    write('\t'),write('cjump '),
    print_term(Result),write(', '),
    print_tmp_l(label, L0), write(', '),
    print_tmp_l(label, L1),nl,
    print_tmp_l(label, L0),write(':'),nl,
    gen_ir(S1, _),
    print_tmp_l(label, L1),write(':'),nl.