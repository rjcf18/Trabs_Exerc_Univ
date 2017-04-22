:-consult(counters).
:-consult(prints).
:-consult(ir).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Dynamic predicates for the temporaries and labels needed for each funct/proc

:-dynamic temps/1.
:-dynamic fptemps/1.
:-dynamic labels/1.

temps(0).
fptemps(0).
labels(0).

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function (also procedure) predicate to call the body and generate the IR for it
fun(Name, _, body(Locals, Stmts, Return)):-
    write('function @'),write(Name),nl,
    body(Locals, Stmts, Return),
    reset_counters.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% variable predicate to generate ir for variables
var(id(_,var,_),_). % ignores the IR generation for globals
var(_, nil).
var(Id, Exp):-
    gen_ir(Exp, Result),
    print_ir(var, _, [Id, Result]),nl,!.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Processes the node list generating the ir for each node
process_nodelist([], []).
process_nodelist([H| T], [HR|TR]):-
    gen_ir(H, HR),
    process_nodelist(T, TR).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Procedure body with several statements
body(Locals, Stmts, nil):-
  is_list(Stmts),
  process_nodelist(Locals, _),
  process_nodelist(Stmts, _), !.
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Procedure body with a single statement
body(Locals, Stmt, nil):-
    process_nodelist(Locals, _),
    gen_ir(Stmt, _), !.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function body with no local variable decls and no statements
body([], nil, Expression):-
    gen_ir(Expression, ValueReturned),
    print_ir(return, _, ValueReturned),!.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function body with local variable decls and several statements
body(Locals, Stmts, Expression):-
    is_list(Stmts),
    process_nodelist(Locals, _),
    process_nodelist(Stmts, _),
    gen_ir(Expression, ValueReturned),
    print_ir(return, _, ValueReturned),!.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION body with local variable decls and a single statement
body(Locals, Stmt, Expression):-
    process_nodelist(Locals, _ResultsList),
    gen_ir(Stmt, _),
    gen_ir(Expression, ValueReturned),
    print_ir(return, _, ValueReturned),!.
                        