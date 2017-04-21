	.text
example:
	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -8
	ori   $t0, $0, 1
	sw    $t0, -8($fp)
l0:	lw    $t0, 4($fp)
	ori   $t1, $0, 0
	slt   $t0, $t1, $t0
	beq   $t0, $0, l2
	j     l1
l1:	lw    $t0, -8($fp)
	lw    $t1, 4($fp)
	mult  $t0, $t1
	mflo  $t0
	sw    $t0, -8($fp)
	lw    $t0, 4($fp)
	ori   $t1, $0, 1
	subu  $t0, $t0, $t1
	sw    $t0, 4($fp)
	j     l0
l2:	lw    $t0, -8($fp)
	or    $v0, $0, $t0
	lw    $ra, -4($fp)
	addiu $sp, $fp, 8
	lw    $fp, 0($fp)
	jr    $ra
