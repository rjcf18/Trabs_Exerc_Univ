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

fibonacci:
	sw $fp, -4($sp)
	addiu $fp, $sp, -4
	sw $ra, -4($fp)
	addiu $sp, $fp, -8
	lw $t0, 4($fp)
	ori $t1, $0, 0
	subu $t0, $t0, $t1
	sltiu $t0, $t0, 1
	beq $t0, $0, l1
	j l0
l1:
	lw $t0, 4($fp)
	ori $t1, $0, 1
	subu $t0, $t0, $t1
	sltiu $t0, $t0, 1
	add $t1, $0, $t0
l0:
	sw $t1, -8($fp)
	lw $t0, -8($fp)
	or $v0, $0, $t0
	lw $ra, -4($fp)
	addiu $sp, $fp, 8
	lw $fp, 0($fp)
	jr $ra

true 
