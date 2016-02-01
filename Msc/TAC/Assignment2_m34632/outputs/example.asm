true.

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

example:
	sw $fp, -4($sp)
	addiu $fp, $sp, -4
	sw $ra, -4($fp)
	addiu $sp, $fp, -8
	ori $t0, $0, 1
	sw $t0, -8($fp)
l0:
	lw $t0, 4($fp)
	ori $t1, $0, 0
	slt $t0, $t1, $t0
	beq $t0, $0, l2
	j l1
l1:
	lw $t0, -8($fp)
	lw $t1, 4($fp)
	mult $t0, $t1
	mflo $t0
	sw $t0, -8($fp)
	lw $t0, 4($fp)
	addiu $t0, $t0, -1
	sw $t0, 4($fp)
	j l0
l2:
	lw $t0, -8($fp)
	or $v0, $0, $t0
	lw $ra, -4($fp)
	addiu $sp, $fp, 8
	lw $fp, 0($fp)
	jr $ra

true 

