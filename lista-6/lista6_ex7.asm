.data
	a: .space 800	# Reserva espaço para a matriz de 10 x 10 elementos (10 * 10 * 8 bytes)
	NUM: .word 10
	NL: .asciiz "\n"
	.align 2
.text
main:
	# Inicializa registradores
	la $s0, NUM # Carrega endereço da variável NUM em $t2
	lw $s0, ($s0) # Carrega valor de NUM em $t2
	
	jal init
	jal print
	
	li $v0, 10
	syscall
	
init: 
	li $t0, 0 # i = 0
	li $t1, 0 # j = 0
	
	loop_i:
		loop_j:
			# a[i][j] = i+j;
			# É preciso converter i+j para double
			add $t2, $t0, $t1		# $t2 = i+j
			
			mtc1.d $t2, $f12		# Move $t2 pra $f12 como double
			cvt.d.w $f12, $f12		# Converte de word para double
			
			# a[i][j] = $f12
			# Endereço de [i][j] será armazenado por $t3
			# E = j*8 + (10*i*8)
			
			mul $t4, $t1, 8			# $t4 = j*8
			mul $t5, $t0, 2		# $t5 = 10*i
			mul $t5, $t5, 8			# $t5 = 10*i*8
			
			la $t3, a			# Carrega em $t3 o endereço base da matriz
			add $t3, $t3, $t4
			add $t3, $t3, $t5
			
			s.d $f12, 0($t3)		# a[i][j] = $f12
			
			
			addi $t1, $t1, 1		# j++;
			lw $s0, NUM
			blt $t1, $s0, loop_j		# Se j < NUM, repete o loop j
			li $t1, 0 # j = 0
		
		addi $t0, $t0, 1	# i++;
		lw $s0, NUM
		blt $t0, $s0, loop_i	# Se i < NUM, repete o loop i
		li $t0, 0 # i = 0
		
	jr $ra
	
print:
	li $t0, 0 # i = 0
	li $t1, 0 # j = 0
	
	ploop_i:
		ploop_j:
			# E = j*8 + (10*i*8)
			mul $t4, $t1, 8			# $t4 = j*8
			mul $t5, $t0, 2		# $t5 = 10*i
			mul $t5, $t5, 8			# $t5 = 10*i*8
			
			la $t3, a			# Carrega em $t3 o endereço base da matriz
			add $t3, $t3, $t4
			add $t3, $t3, $t5

			l.d $f12, 0($t3)
			li $v0, 3
			syscall
			
			li $v0, 4
			la $a0, NL
			syscall	
			
			addi $t1, $t1, 1		# j++;
			lw $s0, NUM
			blt $t1, $s0, ploop_j		# Se j < NUM, repete o loop j
			li $t1, 0 # j = 0
		
		addi $t0, $t0, 1	# i++;
		lw $s0, NUM
		blt $t0, $s0, ploop_i	# Se i < NUM, repete o loop i
		li $t0, 0 # i = 0
		
	jr $ra