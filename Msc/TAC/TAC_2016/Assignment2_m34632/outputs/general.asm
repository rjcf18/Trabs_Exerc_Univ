	.macro i_print$ (%int)
	or $a0, $0, %int
	ori $v0, $0, 1
	syscall
	ori $a0, $0, 0x0A
	ori $v0, $0, 11
	syscall
	.end_macro

.data

true:   .asciiz "true\n" 
false:	.asciiz "false\n"
bool$:  .word false true

	.macro b_print$ (%bool)
	la    $a0, bool$
	sll   $v0, %bool, 2
	addu  $a0, $a0, $v0
	lw    $a0, 0($a0)
	ori   $v0, $0, 4
	syscall
	.end_macro

	.macro r_print$ (%real)
	mov.d $f12, %real
	ori   $v0, $0, 3
	syscall
	ori   $a0, $0, 0x0A
	ori   $v0, $0, 11
	syscall
	.end_macro



.data

.text

global1:	.word	32
true 
global2:	.word	4
true 
gbool:	.word	1
true 
true 
true 
true 
true.

true 
true 
true 
true 
false.

false.

false.

.text

f:
	sw $fp, -4($sp)
	addiu $fp, $sp, -4
	sw $ra, -4($fp)
	addiu $sp, $fp, -4
	lw $t0, 4($fp)
	addiu $t0, $t0, 1
	or $v0, $0, $t0
	lw $ra, -4($fp)
	addiu $sp, $fp, 8
	lw $fp, 0($fp)
	jr $ra

true 
false.

false.

false.

false.


