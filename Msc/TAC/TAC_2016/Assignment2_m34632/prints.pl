:-dynamic printed_text/1.
:-dynamic printed_data/1.

printed_data(false).
printed_text(false).

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Predicates regarding the prints
 %%%%%%%%%%%%%%%%%%%


print_data_section:-
  print_macros, write('\n.data\n\n').

print_text_section:-
  write('.text\n\n').

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Global Variables
 %%%%%%%%%%%%%%%%%%%
print_var(Id, Type):-
  (( printed_data(false),print_data_section,
  retractall(printed_data(_)), asserta(printed_data(true)));
  printed_data(true)),
  write(Id), write(':\t.word\t'),
  ( ( Type=int, write(4));
    ( Type=bool, write(1)) ), nl.

print_var(Id, int, Value):-
  (( printed_data(false),print_data_section, print_text_section,
    retractall(printed_data(_)), asserta(printed_data(true)));
    printed_data(true)),
  write(Id), write(':\t.word\t'), write(Value), nl.

print_var(Id, bool, Value):-
  (( printed_data(false),print_data_section, print_text_section,
     retractall(printed_data(_)), asserta(printed_data(true)));
     printed_data(true)),
  write(Id),write(':\t.word\t'),
  ((Value=true, write(1));(Value=false, write(0))), nl.

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prints for the function (macros, data and text segments)
 %%%%%%%%%%%%%

print_function(Id):-
  ((printed_data(false), print_data_section,
  retractall(printed_data(_)), asserta(printed_data(true)));
  printed_data(true)),
  ((printed_text(false), print_text_section,
  retractall(printed_text(_)), asserta(printed_text(true)));
  printed_text(true)),
  ((Id = main, write('\t.globl main\n')); Id \= main),
  write(Id), write(':\n').

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prints the prologue and epilogue for the function regarding
 %% the stack pointer and stack frames
  %%%%%%%%%%%%%%%%%%%
print_prologue:-
  stack_frame(_, _, LocalsList, _),
  length(LocalsList, NumberOfLocals),
  Index is NumberOfLocals + 1, OffSet is Index * (-4),
  write('\tsw $fp, -4($sp)\n'),
  write('\taddiu $fp, $sp, -4\n'),
  write('\tsw $ra, -4($fp)\n'),
  write('\taddiu $sp, $fp, '), write(OffSet), nl.

print_epilogue:-
  stack_frame(_, ArgsList, _, _ ),
  length(ArgsList, NumberOfArgs),
  N is NumberOfArgs + 1, % + return value
  Offset is N * 4,
  write('\tlw $ra, -4($fp)\n'),
  write('\taddiu $sp, '),write('$fp, '),write(Offset),
  write('\n\tlw $fp, 0($fp)\n'),
  write('\tjr $ra\n').

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Macros for the 3 mentioned prints (i_print, b_print and r_print
 %%%%%%%%%%%%%%%%%%%
macro_i_print:-
  write('\t.macro i_print$ (%int)\n'),
  write('\tor $a0, $0, %int\n'),
  write('\tori $v0, $0, 1\n'),
  write('\tsyscall\n'),
  write('\tori $a0, $0, 0x0A\n'), % 0x0A -> newline,
  write('\tori $v0, $0, 11\n'),
  write('\tsyscall\n'),
  write('\t.end_macro\n\n').

macro_b_print:-
  write('.data\n\ntrue:   .asciiz "true\\n" \nfalse:	.asciiz "false\\n"\n'),
  write('bool$:  .word false true\n\n'),
  write('\t.macro b_print$ (%bool)\n'),
  write('\tla    $a0, bool$\n'),
  write('\tsll   $v0, %bool, 2\n'),
  write('\taddu  $a0, $a0, $v0\n'),
  write('\tlw    $a0, 0($a0)\n'),
  write('\tori   $v0, $0, 4\n'),
  write('\tsyscall\n'),
  write('\t.end_macro\n\n').

macro_r_print:-
  write('\t.macro r_print$ (%real)\n'),
  write('\tmov.d $f12, %real\n'),
  write('\tori   $v0, $0, 3\n'),
  write('\tsyscall\n'),
  write('\tori   $a0, $0, 0x0A\n'),
  write('\tori   $v0, $0, 11\n'),
  write('\tsyscall\n'),
  write('\t.end_macro\n\n').

macro_i_print(Register):-
  write('\ti_print( '), write(Register), write(')'), nl.

macro_b_print(Register):-
  write('\tb_print( '), write(Register), write(')'),nl.

macro_r_print(Register):-
  write('\tr_print( '), write(Register), write(')'),nl.

print_macros:-
  macro_i_print,
  macro_b_print,
  macro_r_print,nl.

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Prints for the stack push and pop instructions
 %%%%%%%%%%%%%%%%%%%
print_stack_push(Register):-
  write('\taddiu $sp, $sp, -4\n'),
  write('\tsw '), write(Register), write(', 0($sp)\n').

print_stack_pop(Register):-
  write('\tlw '), write(Register), write(', 0($sp)\n'),
  write('\taddiu $sp, $sp, 4\n').
