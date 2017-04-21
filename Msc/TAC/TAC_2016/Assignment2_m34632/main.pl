:-consult(stack_operations).
:-consult(instructions).
:-consult(prints).


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Global variables decls and function decls
 %%%%%%%%%%%%%%%%%%%

id(Identifier, var, Type):-
  print_var(Identifier, Type).

id(Identifier, var, Type, Initial_value):-
  print_var(Identifier, Type, Initial_value).

id(Identifier, fun, Type, Formals, Locals):-
  findall(ID, member(id(ID,_), Formals), ArgsList ),
  findall(ID1, member(id(ID1,_), Locals), LocalsList ),
  runtime_stack(RTStack), retractall(runtime_stack(_)),
  append([stack_frame(Identifier, ArgsList, LocalsList,Type)], RTStack, NewRTStack),
  asserta(runtime_stack(NewRTStack)).


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Checks if stack frame for this funtion doesnt already exist in the
 %% runtime stack, creates a stack frame for this function,
  %%  and processes the Instructions
   %%%%%%%%%%%%%%%%%%%

function(Identifier, Instructions):-
  runtime_stack(List),
  member(stack_frame(Identifier, ArgsList, LocalsList,Type), List),
  retractall(stack_frame(_,_,_,_)),
  asserta(stack_frame(Identifier, ArgsList, LocalsList,Type)),
  print_function(Identifier),
  print_prologue,
  process_instructions(Instructions),
  print_epilogue,nl.

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Helper predicates for bit conversions (sign extend 16b to 32b)
 %%%%%%%%%%%%%%%%%%%

signextend_16bto32b(TargetRegister, Value):-
  (Value >= 65536;Value < -32768),
  Upper is Value >> 16,
  Lower is Value /\ 65535,
  lui('$at', Upper),
  ori(TargetRegister, '$at', Lower).

signextend_16bto32b(TargetRegister, Value):-
  Value < 65536,
  ori(TargetRegister, '$0', Value).


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Optimizations regarding i_value, i_add and i_sub
 %%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%
%% i_add optimization
optimization(Inst1, Inst2):-
  ((Inst1 = i_value(Temp, Value),
    Inst2 = i_add(TargetTemp, Temp1, Temp));
  ( Inst1 = i_value(Temp, Value),
    Inst2 = i_add(TargetTemp, Temp, Temp1)) ),
  (Value < 65536;Value >= -32768),
  symbol_table_delete(Temp1, TempR),
  symbol_table_add(TargetTemp, TargetR),
  fetch_correct_syntax(TempR, Register),
  fetch_correct_syntax(TargetR, TargetRegister),
  addiu(TargetRegister, Register, Value).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% i_sub optimization
optimization(Inst1, Inst2):-
  ((Inst1 = i_value(Temp, Value),
    Inst2 = i_sub(TargetTemp, Temp1, Temp));
  ( Inst1 = i_value(Temp, Value),
    Inst2 = i_sub(TargetTemp, Temp, Temp1)) ),
  (Value < 65536;Value >= -32768),
  symbol_table_delete(Temp1, TempR),
  symbol_table_add(TargetTemp, TargetR),
  Value2 is 0-Value,
  fetch_correct_syntax(TempR, Register),
  fetch_correct_syntax(TargetR, TargetRegister),
  addiu(TargetRegister, Register, Value2).


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Processes the instructions list calling the terms in the list
 %%%%%%%%%%%%%%%%%%%

process_instructions([Inst]):-
  ((Inst = call(_, _),
  process_call(Inst)); (call(Inst))).

process_instructions([Inst1,Inst2|T]):-
  optimization(Inst1,Inst2),
  process_instructions(T).

process_instructions([Inst|T]):-
  ((Inst = call(_, _),
  process_call(Inst)); (call(Inst))), process_instructions(T).
