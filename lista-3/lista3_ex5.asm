.data
	A: .word 8
	B: .word 1
.text
	# if (a > b): a = a + 1
	lw $s0, A
	lw $s1, B
	
	bgt $s0, $s1, if
	j else
	
	if:
		add $s0, $s0, $s1
	else:
	
	sw $s0, A
	
	li $v0, 10
	syscall	
