 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Predicates for the Instructions processing (IR and MIPS) %%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fetches the correct syntax for the register
fetch_correct_syntax(Register, CorrectReg):-
  Register < 10,
  atom_concat('$t', Register, CorrectReg).

fetch_correct_syntax(Register, CorrectReg):-
  Register > 9,
  Register2 is Register-10,
  atom_concat('$s', Register2, CorrectReg).

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  IR instructions
 %%%%%%%%%%%%%%%%%%%

i_value(TempTarget, Value):-
 symbol_table_add(TempTarget, TargetR),
 fetch_correct_syntax(TargetR, TargetRegister),
 signextend_16bto32b(TargetRegister, Value).

%% a term had to be created to process the call
%%% instruction due to the built in call predicate
process_call(call(ID, Args)):-
  symbol_table(SymbolTable),
  findall(Temp, member((_,Temp), SymbolTable), Temps),
  subtract(Temps, Args, NewTemps), % removes function arguments from temporaries
  stack_push(NewTemps), stack_push(Args),  % function call
  jal(ID), reverse(NewTemps, ReversedTemps), % retrieve temporaries
  stack_pop(ReversedTemps).

cjump(Temp1, Label1,Label2):-
  symbol_table_delete(Temp1, Reg1),
  fetch_correct_syntax(Reg1, Register),
  beq(Register, Label2),
  j(Label1).

i_add(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  addu(TargetRegister, Register1, Register2).

i_aload(Temp, ID):-
  symbol_table_add(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  stack_frame(_, Args, _, _),
  nth1(Index, Args, ID), length(Args, NArgs),
  Idx is Index - 1, Pos is NArgs - Idx,
  Offset is Pos * 4,
  lw(Register, Offset, '$fp').

i_astore(ID, Temp):-
  symbol_table_delete(Temp, TargetR),
  fetch_correct_syntax(TargetR, TargetRegister),
  stack_frame(_, Args, _, _),
  nth1(Index, Args, ID), length(Args, NArgs),
  Idx is Index - 1, Pos is NArgs - Idx,
  Offset is Pos * 4,
  sw(TargetRegister, Offset, '$fp').

i_call(Target, ID, Args):-
  symbol_table(SymbolTable),
  findall(Temp, member((_,Temp), SymbolTable), Temporaries),
  subtract(Temporaries, Args, NewTemps), %remove args from temporaries
  stack_push(NewTemps), stack_push(Args),  % function call
  jal(ID), symbol_table_add(Target, TargetR),
  fetch_correct_syntax(TargetR, TargetRegister),
  or(TargetRegister, '$0', '$v0'),
  reverse(NewTemps, ReversedTemps),  %retrieve temporaries
  stack_pop(ReversedTemps).

i_copy(TempTarget, TempOrigin):-
  symbol_table_add(TempTarget, TargetR),
  symbol_table_delete(TempOrigin, OriginR),
  fetch_correct_syntax(OriginR, OriginRegister),
  fetch_correct_syntax(TargetR, TargetRegister),
  add(TargetRegister, '$0', OriginRegister).

i_div(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  div(Register1, Register2),
  mflo(TargetRegister).

i_eq(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  subu(TargetRegister, Register1, Register2),
  sltiu(TargetRegister, TargetRegister, 1).


i_inv(TempTarget, TempOrigin):-
  symbol_table_delete(TempOrigin, OriginR),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(OriginR, OriginRegister),
  fetch_correct_syntax(TargetR, TargetRegister),
  %fetch_correct_syntax(0, ZeroRegister),
  subu(TargetRegister, '$0', OriginRegister).

jump(Label):-
  j(Label).

i_le(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  slt(TargetRegister, Register1, Register2),
  xori(TargetRegister, TargetRegister, 1).

i_lload(Temp, ID):-
  symbol_table_add(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  stack_frame(_, _, Locals, _),
  nth1(Index, Locals, ID),
  Pos is Index + 1, Offset is Pos * (-4),
  lw(Register, Offset, '$fp').

i_load(Temp, ID):-
  symbol_table_add(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  la(Register, ID), sw(Register, 0, Register).

i_lstore(ID, Temp):-
  symbol_table_delete(Temp, TargetR),
  fetch_correct_syntax(TargetR, TargetRegister),
  stack_frame(_, _, Locals, _),
  nth1(Index, Locals, ID),
  Pos is Index + 1,
  Offset is Pos * (-4),
  sw(TargetRegister, Offset, '$fp').

i_lt(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  slt(TargetRegister, Register1, Register2).

mod(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  div(Register1, Register2),
  mfhi(TargetRegister).

i_mul(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  mult(Register1, Register2),
  mflo(TargetRegister).

i_ne(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  xor(TargetRegister, Register1, Register2),
  slt(TargetRegister, '$0', TargetRegister).

i_sub(TempTarget, Temp1, Temp2):-
  symbol_table_delete(Temp1, Reg1),
  symbol_table_delete(Temp2, Reg2),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(Reg1, Register1),
  fetch_correct_syntax(Reg2, Register2),
  fetch_correct_syntax(TargetR, TargetRegister),
  subu(TargetRegister, Register1, Register2).

i_print(Temp):-
  symbol_table_delete(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  macro_i_print(Register).

b_print(Temp):-
  symbol_table_delete(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  macro_b_print(Register).

r_print(Temp):-
  symbol_table_delete(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  macro_r_print(Register).

i_return(Value):-
  symbol_table_delete(Value, Reg),
  fetch_correct_syntax(Reg, Register),
  or('$v0', '$0', Register).


i_store(ID, Temp):-
  symbol_table_delete(Temp, Reg),
  fetch_correct_syntax(Reg, Register),
  la('$at', ID), sw(Register, 0, '$at').

not(TempTarget, Temp):-
  symbol_table_delete(Temp, Reg),
  symbol_table_add(TempTarget, TargetR),
  fetch_correct_syntax(TargetR, TargetRegister),
  fetch_correct_syntax(Reg, Register),
  xori(TargetRegister, Register, 1).

return.

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MIPS assembly instructions
 %%%%%%%%%%%%%%%%%%%

add(TargetRegister, Register1, Register2):-
  write('\tadd '), write(TargetRegister), write(', '),
  write(Register1), write(', '), write(Register2), nl.

addi(TargetRegister, Register, Value):-
  write('\taddi '), write(TargetRegister), write(', '),
  write(Register), write(', '), write(Value), nl.

addiu(TargetRegister, Register, Value):-
  write('\taddiu '), write(TargetRegister), write(', '),
  write(Register), write(', '), write(Value), nl.

addu(TargetRegister, Register1, Register2):-
  write('\taddu '), write(TargetRegister), write(', '),
  write(Register1), write(', '), write(Register2), nl.

and(TargetRegister, Register1, Register2):-
  write('\tand '), write(TargetRegister), write(', '),
  write(Register1), write(', '), write(Register2), nl.

andi(TargetRegister, Register, Value):-
  write('\tandi '), write(TargetRegister), write(', '),
  write(Register), write(', '), write(Value), nl.

beq(Register1, Register2, Offset):-
  write('\tbeq '), write(Register1), write(', '),
  write(Register2), write(', '), write(Offset), nl.

beq(Register, Label):-
  write('\tbeq '), write(Register), write(', $0, '), write(Label), nl.

bne(Register1, Register2, Offset):-
  write('\tbne '), write(Register1), write(', '),
  write(Register2), write(', '), write(Offset), nl.

div(Register1, Register2):-
  write('\tdiv '), write(Register1), write(', '), write(Register2), nl.

divu(Register1, Register2):-
  write('\tdivu '), write(Register1), write(', '), write(Register2), nl.

j(Label):-
  write('\tj '), write(Label), nl.

jal(Id):-
  write('\tjal '), write(Id), nl.

jr(Register):-
  write('\tjr '), write(Register), nl.

%%% Pseudo Instruction
la(Register, Label):-
  write('\tla '), write(Register), write(', '), write(Label), nl.

label(Label):-
  write(Label), write(':\n').

lb(TargetRegister, Offset, Address):-
  write('\tlb '), write(TargetRegister), write(', '),
  write(Offset), write('('), write(Address), write(')'), nl.

lui(TargetRegister, Value):-
  write('\tlui '), write(TargetRegister),
  write(', '), write(Value), nl.

lw(TargetRegister, OffSet, Address):-
  write('\tlw '), write(TargetRegister), write(', '),
  write(OffSet), write('('), write(Address), write(')'), nl.

%pseudo instruction
lw(TargetRegister, Address):-
  write('\tlw '), write(TargetRegister), write(', '), write(Address), nl.

mfhi(Register):-
  write('\tmfhi '), write(Register), nl.

mflo(Register):-
  write('\tmflo '), write(Register), nl.

mult(Register1, Register2):-
  write('\tmult '), write(Register1), write(', '), write(Register2), nl.

multu(Register1, Register2):-
  write('\tmultu '), write(Register1), write(', '), write(Register2), nl.

%% pseudo instruction
nop:-
  sll('$0', '$0', 0).

or(TargetRegister, Register1, Register2):-
  write('\tor '),write(TargetRegister), write(', '),
  write(Register1), write(', '), write(Register2), nl.

ori(TargetRegister, Register, Value):-
  write('\tori '), write(TargetRegister),
  write(', '), write(Register), write(', '), write(Value), nl.

sb(TargetRegister, OffSet, Address):-
  write('\tsb '), write(TargetRegister), write(', '),
  write(OffSet), write('('), write(Address), write(')'), nl.

sll(TargetRegister, Register, Value):-
  write('\tsll '),write(TargetRegister), write(', '),
  write(Register), write(', '), write(Value), nl.

slt(TargetRegister, Register1, Register2):-
  write('\tslt '), write(TargetRegister), write(', '),
  write(Register1),write(', '), write(Register2), nl.

slti(TargetRegister, Register, Value):-
  write('\tslti '), write(TargetRegister), write(', '),
  write(Register), write(', '), write(Value), nl.

sltiu(TargetRegister, Register, Value):-
  write('\tsltiu '), write(TargetRegister), write(', '),
  write(Register), write(', '), write(Value), nl.

sltu(TargetRegister, Register1, Register2):-
  write('\tsltu '), write(TargetRegister), write(', '),
  write(Register1), write(', '), write(Register2), nl.

sub(TargetRegister, Register1, Register2):-
  write('\tsub '), write(TargetRegister), write(', '),
  write(Register1), write(', '), write(Register2), nl.

subu(TargetRegister, Register1, Register2):-
  write('\tsubu '), write(TargetRegister), write(', '),
  write(Register1), write(', '), write(Register2), nl.

sw(TargetRegister, OffSet, Address):-
  write('\tsw '), write(TargetRegister), write(', '),
  write(OffSet), write('('), write(Address), write(')'), nl.

%% pseudo instruction
sw(TargetRegister, Address):-
  write('\tsw '), write(TargetRegister), write(', '), write(Address), nl.

xor(TargetRegister, Register1, Register2):-
  write('xor '), write(TargetRegister), write(', '),
  write(Register1), write(', '), write(Register2), nl.

xori(TargetRegister, Register, Value):-
  write('\txori '), write(TargetRegister), write(', '),
  write(Register), write(', '), write(Value), nl.
