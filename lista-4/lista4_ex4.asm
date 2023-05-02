# Implemente em Assembly do MIPS o código abaixo, escrito em linguagem C. Utilize as chamadas de
# sistema (syscall) para implementar as funções printf() e scanf().

# int n1, n2;
# void leitura() {
#	printf("\nDigite o valor do primeiro número: ");
#	scanf("%d", &n1);
#	printf("\nDigite o valor do segundo número: ");
#	scanf("%d", &n2);
# }
# int soma(int n1, int n2) {
#	leitura();
#	return (n1 + n2);
# };
# int main() {
#	printf("\nO resultado da soma é: %d", soma(n1, n2));
#	return 0;
# }

.data
	N1: .word 0
	N2: .word 0
	prompt1: .asciiz "\nDigite o valor do primeiro número: "
	.align 2
	prompt2: .asciiz "\nDigite o valor do segundo número: "
	.align 2
	result: .asciiz "\nO resultado da soma é: "
	.align 2
.text
main:
	jal soma
	move $s0, $v0
	
	la $a0, result
	li $v0, 4
	syscall
	
	move $a0, $s0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
soma:
	subu $sp, $sp, 4	# Libera uma word de espaço na stack
	sw $ra, ($sp)		# Armazena o endereço de retorno na posição liberada
	
	jal leitura
	
	lw $t0, N1
	lw $t1, N2
	add $v0, $t0, $t1
	
	lw $ra, ($sp)		# Pega novamente o valor que foi armazenado na stack
	addu $sp, $sp, 4	# Desempilha a stack
	jr $ra			# Retorna

leitura:
	# Imprime a prompt1
	la $a0, prompt1
	li $v0, 4
	syscall
	# Lê o primeiro valor
	li $v0, 5
	syscall
	move $t0, $v0
	
	# Imprime a prompt2
	la $a0, prompt2
	li $v0, 4
	syscall
	# Lê o segundo valor
	li $v0, 5
	syscall
	move $t1, $v0
	
	la $t2, N1
	la $t3, N2
	sw $t0, ($t2)
	sw $t1, ($t3)
	
	jr $ra