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

n:	.word	26
true 
true.

true.

true.

.text

sub:
	sw $fp, -4($sp)
	addiu $fp, $sp, -4
	sw $ra, -4($fp)
	addiu $sp, $fp, -4
	lw $t0, 8($fp)
	lw $t1, 4($fp)
	subu $t0, $t0, $t1
	or $v0, $0, $t0
	lw $ra, -4($fp)
	addiu $sp, $fp, 12
	lw $fp, 0($fp)
	jr $ra

true 
fibonacci:
	sw $fp, -4($sp)
	addiu $fp, $sp, -4
	sw $ra, -4($fp)
	addiu $sp, $fp, -8
	lw $t0, 4($fp)
	ori $t1, $0, 0
	subu $t0, $t0, $t1
	sltiu $t0, $t0, 1
	beq $t0, $0, l3
	j l0
l3:
	lw $t0, 4($fp)
	ori $t1, $0, 1
	subu $t0, $t0, $t1
	sltiu $t0, $t0, 1
	beq $t0, $0, l1
	j l0
l0:
	lw $t0, 4($fp)
	sw $t0, -8($fp)
	j l2
l1:
	lw $t0, 4($fp)
	addiu $t0, $t0, -1
	addiu $sp, $sp, -4
	sw $t0, 0($sp)
	jal fibonacci
	or $t0, $0, $v0
	lw $t1, 4($fp)
	ori $t2, $0, 2
	addiu $sp, $sp, -4
	sw $t0, 0($sp)
	addiu $sp, $sp, -4
	sw $t1, 0($sp)
	addiu $sp, $sp, -4
	sw $t2, 0($sp)
	jal sub
	or $t0, $0, $v0
	lw $t1, 0($sp)
	addiu $sp, $sp, 4
	addiu $sp, $sp, -4
	sw $t1, 0($sp)
	addiu $sp, $sp, -4
	sw $t0, 0($sp)
	jal fibonacci
	or $t0, $0, $v0
	lw $t1, 0($sp)
	addiu $sp, $sp, 4

