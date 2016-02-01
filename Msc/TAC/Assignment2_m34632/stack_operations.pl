:-dynamic stack_frame/4.
:-dynamic runtime_stack/1.
:-dynamic register_stack/1.
:-dynamic symbol_table/1.


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  call/runtime stack in cases of function calls within functions holding each
 %%  stack frame
  %%%%%%%%%%%%%%%%%%%

runtime_stack([]).

%% will hold the temporaries
symbol_table([]).

stack_frame(id, [], [], type).

%% stack of registers
register_stack(List):-
  numlist(0,18, List).

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Pop and push predicates for registers
 %%%%%%%%%%%%%%%%%%%

reg_stack_pop(E):-
  register_stack([E|T]),
  retractall(register_stack(_)),
  asserta(register_stack(T)).

reg_stack_push(Register):-
  register_stack(Stack),
  retractall(register_stack(_)),
  sort([Register|Stack], SortedStack), % natural merge sort
  asserta(register_stack(SortedStack)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Remove Symbol Table temporaries that are no longer being used
 %%%  and restore the registers
  %%%%%%%%%%%%%%%%%%%

symbol_table_delete(Temporary, Register):-
  symbol_table(SymbolTable),
  retractall(symbol_table(_)),
  remove_element(SymbolTable, Temporary, NewSymbolTable, Register),
  asserta(symbol_table(NewSymbolTable)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Save temporaries that will be used in order to know in which
 %%%  register the temporary will be saved
  %%%%%%%%%%%%%%%%%%%%

symbol_table_add(Temporary, Register):-
  symbol_table(SymbolTable),
  retractall(symbol_table(_)),
  add_element(SymbolTable, Temporary, NewSymbolTable, Register),
  asserta(symbol_table(NewSymbolTable)).

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Builds the new symbol table without the temporary to be removed from the
 %%  symbol table and pushes the register to the register stack
  %%%%%%%%%%%%%%%%%%%

remove_element([(Register, Elem)|T], Elem, T, Register):-
  reg_stack_push(Register).

remove_element([(Register, Temp)|T], Elem, [(Register, Temp)| L], RegisterE):-
  Temp \= Elem,
  remove_element(T, Elem, L, RegisterE).

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Builds the new symbol table with the temporary to be added to the symbol table
 %%  and pops the register
  %%%%%%%%%%%%%%%%%%%

add_element(SymbolTable, Elem, [(Register, Elem)|SymbolTable], Register):-
  reg_stack_pop(Register).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%% Push and pop to the stack
  %%%%%%%%%%%%%%%%%%%

stack_push([]).
stack_push([Temp|T]):-
  symbol_table_delete(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  print_stack_push(Register),
  stack_push(T).

stack_pop([]).
stack_pop([Temp|T]):-
  symbol_table_add(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  print_stack_pop(Register),
  stack_pop(T).
