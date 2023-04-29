.data
	string: .space 8
	.align 2
.text
main:
	la $a0, string		# $a0 = address of input buffer
	la $a1, 8		# $a1 = maximum number of characters to read 
	li $v0, 8
	syscall

	li $s0, 0
	li $s2, 'a'
	li $s3, 0		# Contador de iterações

loop:
	beq $s3, 8, end
	lb $t0, ($a0)
	addi $s3, $s3, 1
	addi $a0, $a0, 1	# Incrementa o contador do loop
	beq $t0, $s2, contador
	j loop

contador:
	addi $s0,$s0, 1		# Incrementa o contador de "a"
	j loop

end:
	move $a0, $s0
	li $v0, 1
	syscall
