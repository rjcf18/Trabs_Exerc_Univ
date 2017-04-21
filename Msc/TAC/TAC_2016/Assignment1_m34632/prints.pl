 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Predicates for printing the IR for each node %%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%
% print the terms
print_term(term(_, (T,int), _)):-
    write(t),write(T).
  
print_term(term(_, (F, real), _)):-
    write(fp),write(F).
    
print_term(term(Name, (_,_), _)):-
    write('@'),write(Name).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% helper predicate to print a list of terms
print_list([H]):-print_term(H).
print_list([H|T]):-
    print_term(H), write(', '),print_list(T).

%%%%%%%%%%%%%%%%%%%%%%%%
%prints the type prefix
print_type(int):-
    write('i_').
print_type(real):-
    write('r_').
print_type(bool):-
    write('i_').
print_type(none).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%prints the load type given the scope of the variables
print_load(var):-write('load ').
print_load(local):-write('lload ').
print_load(arg):-write('aload ').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%prints the store type given the scope of the variables
print_store(var):-write('store ').
print_store(local):-write('lstore ').
print_store(arg):-write('astore ').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%prints the temporaries (for floats and integers) and labels 
print_tmp_l(int, T):-
    write(t),write(T).
print_tmp_l(bool, T):-
    write(t),write(T).
print_tmp_l(real, F):-
    write(fp),write(F).
print_tmp_l(label, L):-
    write(l),write(L).
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% outputs the variable IR
print_ir(var, _, List):-
    nth1(1, List, Var), 
    nth1(2, List, Origin),
    Var = id(Name, Kind, Type),
    write('\t'), write('@'),write(Name),write(' <- '),
    print_type(Type),print_store(Kind), print_term(Origin),nl.
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% outputs the literals IR
print_ir(literal, TYPE, Temp):-
    Temp = term(literal, (T, TYPE), Value),
    write('\t'),print_tmp_l(TYPE,T),write(' <- '),
    print_type(TYPE),write('value '),write(Value),nl.    

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% outputs the IDs IR

print_ir(id, (TYPE, load), Temp):-
    Temp = term((ID,arg),(T, TYPE), _),
    write('\t'),print_tmp_l(TYPE,T),write(' <- '),
    print_type(TYPE),print_load(arg),write('@'),write(ID),nl,!.

print_ir(id, (TYPE, load), Temp):-
    Temp = term((ID,local),(T, TYPE), _),
    write('\t'),print_tmp_l(TYPE,T),write(' <- '),
    print_type(TYPE),print_load(local),write('@'),write(ID),nl,!.

print_ir(id, (TYPE, load), Temp):-
    Temp = term((ID,var),(T, TYPE), _),
    write('\t'),print_tmp_l(TYPE,T),write(' <- '),
    print_type(TYPE),print_load(var),write('@'),write(ID),nl,!.  
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% outputs the IR for assigns

print_ir(assign, (_, store), TermList):-
    nth1(1, TermList, Destination),
    nth1(2, TermList, Origin),
    Destination = term( (Name, Kind), ( _, Type), _),
    write('\t'),write('@'), write(Name),write(' <- '),
    print_type(Type), print_store(Kind),
    Origin = term( _,(T2, TYPE2), _),
    print_tmp_l(TYPE2,T2), nl,!.

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% outputs the IR for the value coercion

print_ir(toreal, _, TermList):-
    nth1(1, TermList, Destination),
    nth1(2, TermList, Origin),
    write('\t'), print_term(Destination), 
    write(' <- '), print_operator(toreal),
    print_term(Origin),nl,!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs the IR for print function
print_ir(print, Type, Term):-
    write('\t'),print_type(Type),
    write('print '),print_term(Term),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs the IR for the symmetric value funct

print_ir(inv, Type, TermList):-
    nth1(1, TermList, Destination),
    nth1(2, TermList, Origin),
    write('\t'),print_term(Destination),write(' <- '),
    print_type(Type),write('inv '),print_term(Origin),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs the IR for the calls (procedures and functions)


print_ir(call_procedure, Name, TermList):-
    write('\t'),write('call @'),write(Name),write(', [ '),
    print_list(TermList), write(' ]'),nl,!.

print_ir(call_function, (Name, Type), [Destination| TermList]):-
    write('\t'),print_term(Destination), write(' <- '),
    print_type(Type),write('call @'),write(Name),write(', [ '),
    print_list(TermList), write(' ]'),nl,!.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs the IR for the return    
    
print_ir(return, _, Temp):-
    Temp = term(_, (_, Type),_),
    write('\t'),print_type(Type), write('return '),print_term(Temp),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs the IR for the copy

print_ir(copy, _, List):-
    nth1(1, List, Destination),
    nth1(2, List, Origin), 
    Destination = term( _, (T, Type),_),
    Origin = term(_,(T1, Type),_),
    write('\t'),print_tmp_l(Type,T),write(' <- '),print_type(Type),write('copy '),
    print_tmp_l(Type, T1),nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs the IR for binary operations

print_ir(OP, Type, TermList):-
    nth1(1, TermList, Term1), 
    nth1(2, TermList, Term2),
    nth1(3, TermList, Term3),
    Term1 = term(_, (T1, Type1),_),
    Term2 = term(_, (T2, Type2),_),
    Term3 = term(_, (T3, Type3),_),
    write('\t'),print_tmp_l(Type3,T3), write(' <- '),
    print_type(Type), print_operator(OP),
    print_tmp_l(Type1,T1), write(', '),
    print_tmp_l(Type2,T2), nl,!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs the IR for unary operations

print_ir(OP, unary, TermList):-
    nth1(1, TermList, Term1),
    nth1(2, TermList, Term2),
    Term1 = term(_, (T1, Type1),_),
    Term2 = term(_, (T2, Type2),_),
    write('\t'),print_tmp_l(Type2,T2), write(' <- '),print_operator(OP),
    print_tmp_l(Type1,T1),nl,!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Outputs the operations

print_operation(OP, Type, TermList):-
    arg(1, TermList, Term1),
    arg(2, TermList, Term2),
    arg(3, TermList, Term3),
    print_term(Term3), write(' <- '),
    print_type(Type),print_operator(OP),
    print_term(Term2), write(', '),
    print_term(Term1),nl.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Outputs the operators given its atomic "identifier"

print_operator(plus):-write('add ').
print_operator(minus):-write('sub ').
print_operator(times):-write('mul ').
print_operator(div):-write('div ').

print_operator(eq):-write('eq ').
print_operator(ne):-write('ne ').
print_operator(lt):-write('lt ').
print_operator(le):-write('le ').

print_operator(or):-write('or ').
print_operator(and):-write('and ').
print_operator(not):-write('not ').

print_operator(toreal):-write('itor '). 
