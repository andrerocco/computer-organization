.data
	V: .space 24
.text
	la $s0, V

	# V[0] = 1
	li $t0, 1
	sw $t0, 0($s0)
	
	# V[1] = 3;
	li $t0, 3
	sw $t0, 4($s0)
	
	# V[2] = 2;
	li $t0, 2
	sw $t0, 8($s0)
	
	# V[3] = 1;
	li $t0, 1
	sw $t0, 12($s0)
	
	# V[4] = 4;
	li $t0, 4
	sw $t0, 16($s0)
	
	# V[5] = 5;
	li $t0, 5
	sw $t0, 20($s0)
