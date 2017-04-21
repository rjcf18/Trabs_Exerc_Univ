	.data
global1:	.word 32
global2:	.space 4
gbool:	.word 1

	# print an integer
	.macro i_print$ (%int)
	or    $a0, $0, %int
	ori   $v0, $0, 1
	syscall
	ori   $a0, $0, '\n'
	ori   $v0, $0, 11
	syscall
	.end_macro

	.data
true:	.asciiz "true\n"
false:	.asciiz "false\n"

	# print a boolean value
	.macro b_print$ (%bool)
	beq   %bool, $0, _$bp1
	nop
	la    $a0, true
	j     _$bp2
	nop
_$bp1:	la    $a0, false
_$bp2:	ori   $v0, $0, 4
	syscall
	.end_macro

	.text
p:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -4
	lw    $t0, 4($fp)
	i_print$ $t0
	lw    $t0, 4($fp)
	ori   $t1, $0, 1
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	beq   $t0, $0, l1
	j     l0
l0:	ori   $t0, $0, 1
	b_print$ $t0
	ori   $t0, $0, 1
	ori   $t1, $0, 1
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 1
	ori   $t1, $0, 2
	subu  $t0, $t0, $t1
	sltu  $t0, $0, $t0
	b_print$ $t0
	ori   $t0, $0, 1
	ori   $t1, $0, 2
	slt   $t0, $t0, $t1
	b_print$ $t0
	ori   $t0, $0, 4
	ori   $t1, $0, 5
	slt   $t0, $t1, $t0
	xori  $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 3
	ori   $t1, $0, 4
	subu  $t1, $0, $t1
	slt   $t0, $t1, $t0
	b_print$ $t0
	ori   $t0, $0, 9
	ori   $t1, $0, 9
	slt   $t0, $t0, $t1
	xori  $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 1
	ori   $t1, $0, 2
	slt   $t0, $t1, $t0
	xori  $t0, $t0, 1
	b_print$ $t0
	j     l3
l3:	ori   $t0, $0, 1
	b_print$ $t0
	j     l5
l4:	ori   $t0, $0, 0
	b_print$ $t0
l5:	ori   $t0, $0, 1
	ori   $t1, $0, 1
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	beq   $t0, $0, l7
	j     l6
l6:	ori   $t0, $0, 1
	b_print$ $t0
	j     l8
l7:	ori   $t0, $0, 0
	b_print$ $t0
l8:	ori   $t0, $0, 1
	ori   $t1, $0, 2
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	beq   $t0, $0, l9
	j     l10
l9:	ori   $t0, $0, 1
	b_print$ $t0
	j     l11
l10:	ori   $t0, $0, 0
	b_print$ $t0
l11:	ori   $t0, $0, 1
	ori   $t1, $0, 2
	slt   $t0, $t0, $t1
	beq   $t0, $0, l13
	j     l12
l12:	ori   $t0, $0, 1
	b_print$ $t0
	j     l14
l13:	ori   $t0, $0, 0
	b_print$ $t0
l14:	ori   $t0, $0, 4
	ori   $t1, $0, 5
	slt   $t0, $t1, $t0
	beq   $t0, $0, l15
	j     l16
l15:	ori   $t0, $0, 1
	b_print$ $t0
	j     l17
l16:	ori   $t0, $0, 0
	b_print$ $t0
l17:	ori   $t0, $0, 3
	ori   $t1, $0, 4
	subu  $t1, $0, $t1
	slt   $t0, $t1, $t0
	beq   $t0, $0, l19
	j     l18
l18:	ori   $t0, $0, 1
	b_print$ $t0
	j     l20
l19:	ori   $t0, $0, 0
	b_print$ $t0
l20:	ori   $t0, $0, 9
	ori   $t1, $0, 9
	slt   $t0, $t0, $t1
	beq   $t0, $0, l21
	j     l22
l21:	ori   $t0, $0, 1
	b_print$ $t0
	j     l23
l22:	ori   $t0, $0, 0
	b_print$ $t0
l23:	ori   $t0, $0, 1
	ori   $t1, $0, 2
	slt   $t0, $t1, $t0
	beq   $t0, $0, l24
	j     l25
l24:	ori   $t0, $0, 1
	b_print$ $t0
	j     l26
l25:	ori   $t0, $0, 0
	b_print$ $t0
l26:	j     l2
l1:	ori   $t0, $0, 0
	b_print$ $t0
	ori   $t0, $0, 1
	ori   $t1, $0, 0
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 3
	ori   $t1, $0, 3
	subu  $t0, $t0, $t1
	sltu  $t0, $0, $t0
	b_print$ $t0
	ori   $t0, $0, 3
	ori   $t1, $0, 1
	slt   $t0, $t0, $t1
	b_print$ $t0
	ori   $t0, $0, 8
	ori   $t1, $0, 3
	slt   $t0, $t1, $t0
	xori  $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 3
	ori   $t1, $0, 3
	slt   $t0, $t1, $t0
	b_print$ $t0
	ori   $t0, $0, 4
	ori   $t1, $0, 8
	slt   $t0, $t0, $t1
	xori  $t0, $t0, 1
	b_print$ $t0
	j     l28
l27:	ori   $t0, $0, 1
	b_print$ $t0
	j     l29
l28:	ori   $t0, $0, 0
	b_print$ $t0
l29:	ori   $t0, $0, 1
	ori   $t1, $0, 0
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	beq   $t0, $0, l31
	j     l30
l30:	ori   $t0, $0, 1
	b_print$ $t0
	j     l32
l31:	ori   $t0, $0, 0
	b_print$ $t0
l32:	ori   $t0, $0, 3
	ori   $t1, $0, 3
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	beq   $t0, $0, l33
	j     l34
l33:	ori   $t0, $0, 1
	b_print$ $t0
	j     l35
l34:	ori   $t0, $0, 0
	b_print$ $t0
l35:	ori   $t0, $0, 3
	ori   $t1, $0, 1
	slt   $t0, $t0, $t1
	beq   $t0, $0, l37
	j     l36
l36:	ori   $t0, $0, 1
	b_print$ $t0
	j     l38
l37:	ori   $t0, $0, 0
	b_print$ $t0
l38:	ori   $t0, $0, 8
	ori   $t1, $0, 3
	slt   $t0, $t1, $t0
	beq   $t0, $0, l39
	j     l40
l39:	ori   $t0, $0, 1
	b_print$ $t0
	j     l41
l40:	ori   $t0, $0, 0
	b_print$ $t0
l41:	ori   $t0, $0, 3
	ori   $t1, $0, 3
	slt   $t0, $t1, $t0
	beq   $t0, $0, l43
	j     l42
l42:	ori   $t0, $0, 1
	b_print$ $t0
	j     l44
l43:	ori   $t0, $0, 0
	b_print$ $t0
l44:	ori   $t0, $0, 4
	ori   $t1, $0, 8
	slt   $t0, $t0, $t1
	beq   $t0, $0, l45
	j     l46
l45:	ori   $t0, $0, 1
	b_print$ $t0
	j     l47
l46:	ori   $t0, $0, 0
	b_print$ $t0
l47:
l2:	lw    $ra, -4($fp)
	addiu $sp, $fp, 8
	lw    $fp, 0($fp)
	jr    $ra

	.text
or:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -4
	j     l51
l51:	j     l49
l48:	ori   $t0, $0, 1
	b_print$ $t0
	j     l50
l49:	ori   $t0, $0, 0
	b_print$ $t0
l50:	j     l55
l55:	j     l52
l52:	ori   $t0, $0, 1
	b_print$ $t0
	j     l54
l53:	ori   $t0, $0, 0
	b_print$ $t0
l54:	j     l56
l59:	j     l57
l56:	ori   $t0, $0, 1
	b_print$ $t0
	j     l58
l57:	ori   $t0, $0, 0
	b_print$ $t0
l58:	j     l60
l63:	j     l60
l60:	ori   $t0, $0, 1
	b_print$ $t0
	j     l62
l61:	ori   $t0, $0, 0
	b_print$ $t0
l62:	lw    $ra, -4($fp)
	addiu $sp, $fp, 4
	lw    $fp, 0($fp)
	jr    $ra

	.text
and:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -4
	j     l65
l67:	j     l65
l64:	ori   $t0, $0, 1
	b_print$ $t0
	j     l66
l65:	ori   $t0, $0, 0
	b_print$ $t0
l66:	j     l69
l71:	j     l68
l68:	ori   $t0, $0, 1
	b_print$ $t0
	j     l70
l69:	ori   $t0, $0, 0
	b_print$ $t0
l70:	j     l75
l75:	j     l73
l72:	ori   $t0, $0, 1
	b_print$ $t0
	j     l74
l73:	ori   $t0, $0, 0
	b_print$ $t0
l74:	j     l79
l79:	j     l76
l76:	ori   $t0, $0, 1
	b_print$ $t0
	j     l78
l77:	ori   $t0, $0, 0
	b_print$ $t0
l78:	lw    $ra, -4($fp)
	addiu $sp, $fp, 4
	lw    $fp, 0($fp)
	jr    $ra

	.text
f:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -4
	lw    $t0, 4($fp)
	ori   $t1, $0, 1
	addu  $t0, $t0, $t1
	or    $v0, $0, $t0
	lw    $ra, -4($fp)
	addiu $sp, $fp, 8
	lw    $fp, 0($fp)
	jr    $ra

	.text
q:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -8
	ori   $t0, $0, 0
	sw    $t0, -8($fp)
l80:	lw    $t0, -8($fp)
	ori   $t1, $0, 2
	slt   $t0, $t0, $t1
	beq   $t0, $0, l82
	j     l81
l81:	lw    $t0, -8($fp)
	addiu $sp, $sp, -4
	sw    $t0, 0($sp)
	jal   p
	lw    $t0, -8($fp)
	addiu $sp, $sp, -4
	sw    $t0, 0($sp)
	jal   f
	or    $t0, $0, $v0
	sw    $t0, -8($fp)
	j     l80
l82:	lw    $ra, -4($fp)
	addiu $sp, $fp, 4
	lw    $fp, 0($fp)
	jr    $ra

	.text
r:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -4
	lw    $t0, 4($fp)
	la    $t1, global2
	lw    $t1, 0($t1)
	addu  $t0, $t0, $t1
	sw    $t0, 4($fp)
	lw    $t0, 4($fp)
	la    $at, global1
	sw    $t0, 0($at)
	lw    $ra, -4($fp)
	addiu $sp, $fp, 8
	lw    $fp, 0($fp)
	jr    $ra

	.text
arith:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -4
	ori   $t0, $0, 33
	ori   $t1, $0, 3
	ori   $t2, $0, 30
	addu  $t1, $t1, $t2
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 33
	ori   $t1, $0, 3
	ori   $t2, $0, 11
	mult  $t1, $t2
	mflo  $t1
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 33
	ori   $t1, $0, 40
	ori   $t2, $0, 7
	subu  $t1, $t1, $t2
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 33
	ori   $t1, $0, 99
	ori   $t2, $0, 3
	div   $t1, $t2
	mflo  $t1
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 33
	ori   $t1, $0, 67
	ori   $t2, $0, 34
	div   $t1, $t2
	mfhi  $t1
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 33
	ori   $t1, $0, 33
	subu  $t1, $0, $t1
	subu  $t1, $0, $t1
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	lw    $ra, -4($fp)
	addiu $sp, $fp, 4
	lw    $fp, 0($fp)
	jr    $ra

	.text
	.globl main
main:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -8
	ori   $t0, $0, 34
	sw    $t0, -8($fp)
	jal   q
	ori   $t0, $0, 2
	i_print$ $t0
	jal   or
	ori   $t0, $0, 3
	i_print$ $t0
	jal   and
	ori   $t0, $0, 4
	i_print$ $t0
	jal   arith
	ori   $t0, $0, 5
	i_print$ $t0
	ori   $t0, $0, 33
	la    $at, global2
	sw    $t0, 0($at)
	la    $t0, global1
	lw    $t0, 0($t0)
	ori   $t1, $0, 1
	addu  $t0, $t0, $t1
	la    $t1, global2
	lw    $t1, 0($t1)
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	la    $t0, global1
	lw    $t0, 0($t0)
	lw    $t1, -8($fp)
	addu  $t0, $t0, $t1
	ori   $t1, $0, 2
	la    $t2, global2
	lw    $t2, 0($t2)
	mult  $t1, $t2
	mflo  $t1
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	la    $t0, global2
	lw    $t0, 0($t0)
	addiu $sp, $sp, -4
	sw    $t0, 0($sp)
	jal   r
	la    $t0, global2
	lw    $t0, 0($t0)
	ori   $t1, $0, 2
	mult  $t0, $t1
	mflo  $t0
	la    $t1, global1
	lw    $t1, 0($t1)
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	ori   $t0, $0, 14
	ori   $t1, $0, 1
	addiu $sp, $sp, -4
	sw    $t0, 0($sp)
	addiu $sp, $sp, -4
	sw    $t1, 0($sp)
	jal   f
	or    $t1, $0, $v0
	lw    $t0, 0($sp)
	addiu $sp, $sp, 4
	ori   $t2, $0, 2
	addiu $sp, $sp, -4
	sw    $t0, 0($sp)
	addiu $sp, $sp, -4
	sw    $t1, 0($sp)
	addiu $sp, $sp, -4
	sw    $t2, 0($sp)
	jal   f
	or    $t2, $0, $v0
	lw    $t1, 0($sp)
	addiu $sp, $sp, 4
	lw    $t0, 0($sp)
	addiu $sp, $sp, 4
	ori   $t3, $0, 3
	addiu $sp, $sp, -4
	sw    $t0, 0($sp)
	addiu $sp, $sp, -4
	sw    $t1, 0($sp)
	addiu $sp, $sp, -4
	sw    $t2, 0($sp)
	addiu $sp, $sp, -4
	sw    $t3, 0($sp)
	jal   f
	or    $t3, $0, $v0
	lw    $t2, 0($sp)
	addiu $sp, $sp, 4
	lw    $t1, 0($sp)
	addiu $sp, $sp, 4
	lw    $t0, 0($sp)
	addiu $sp, $sp, 4
	ori   $t4, $0, 4
	addiu $sp, $sp, -4
	sw    $t0, 0($sp)
	addiu $sp, $sp, -4
	sw    $t1, 0($sp)
	addiu $sp, $sp, -4
	sw    $t2, 0($sp)
	addiu $sp, $sp, -4
	sw    $t3, 0($sp)
	addiu $sp, $sp, -4
	sw    $t4, 0($sp)
	jal   f
	or    $t4, $0, $v0
	lw    $t3, 0($sp)
	addiu $sp, $sp, 4
	lw    $t2, 0($sp)
	addiu $sp, $sp, 4
	lw    $t1, 0($sp)
	addiu $sp, $sp, 4
	lw    $t0, 0($sp)
	addiu $sp, $sp, 4
	addu  $t3, $t3, $t4
	addu  $t2, $t2, $t3
	addu  $t1, $t1, $t2
	subu  $t0, $t0, $t1
	sltiu $t0, $t0, 1
	b_print$ $t0
	lw    $ra, -4($fp)
	addiu $sp, $fp, 4
	lw    $fp, 0($fp)
	jr    $ra
