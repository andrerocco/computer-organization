.data
	V: .space 24
.text
	la $s0, V
	li $t1, 0
	
	# V[0] = 1
	li $t0, 1
	sw $t0, ($s0)
	addi $s0, $s0, 4
	
	# V[1] = 3;
	li $t0, 3
	sw $t0, ($s0)
	addi $s0, $s0, 4
	
	# V[2] = 2;
	li $t0, 2
	sw $t0, ($s0)
	addi $s0, $s0, 4
		
	# V[3] = 1;
	li $t0, 1
	sw $t0, ($s0)
	addi $s0, $s0, 4
	
	# V[4] = 4;
	li $t0, 4
	sw $t0, ($s0)
	addi $s0, $s0, 4
	
	# V[5] = 5;
	li $t0, 5
	sw $t0, ($s0)
	addi $s0, $s0, 4