	.text
triangular:
	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -12
	lw    $t0, 4($fp)
	sw    $t0, -8($fp)
	lw    $t0, -8($fp)
	ori   $t1, $0, 0
	slt   $t0, $t1, $t0
	beq   $t0, $0, l1
	j     l0
l0:	lw    $t0, 4($fp)
	ori   $t1, $0, 1
	subu  $t0, $t0, $t1
	addiu $sp, $sp, -4
	sw    $t0, 0($sp)
	jal   triangular
	or    $t0, $0, $v0
	sw    $t0, -12($fp)
	lw    $t0, -8($fp)
	lw    $t1, -12($fp)
	addu  $t0, $t0, $t1
	sw    $t0, -8($fp)
l1:	lw    $t0, -8($fp)
	or    $v0, $0, $t0
	lw    $ra, -4($fp)
	addiu $sp, $fp, 8
	lw    $fp, 0($fp)
	jr    $ra

