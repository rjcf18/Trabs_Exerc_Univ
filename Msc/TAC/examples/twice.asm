	.text
twice:	sw    $fp, -4($sp)
	addiu $fp, $sp, -4
	sw    $ra, -4($fp)
	addiu $sp, $fp, -4
	ori   $t0, $0, 2
	lw    $t1, 4($fp)
	mult  $t0, $t1
	mflo  $t0
	or    $v0, $0, $t0
	lw    $ra, -4($fp)
	addiu $sp, $fp, 8
	lw    $fp, 0($fp)
	jr    $ra
