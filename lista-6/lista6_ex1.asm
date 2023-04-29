# Considere que o valor de ? (pi) seja 3.141592653589793. Crie um programa que calcule a �rea de
# um c�rculo. O usu�rio dever� informar o raio do c�rculo via teclado.

.data
	# PI est� sendo armazenado como um .double aumentar a precis�o de seu armazenamento
	PI: .double 3.141592653589793
.text
MAIN:
	l.d $f2, PI # $f2 = PI
	
	li $v0, 6 # Ler um float
	syscall # $f0 = raio
	
	jal CALCULA_AREA
	# Quando jr $ra for chamada, o c�digo abaixo voltar� a ser executado
	
	# Encerra o programa
    	li $v0, 10
    	syscall

CALCULA_AREA:
	# Area = pi * raio * raio
	mul.d $f12, $f2, $f2
	mul.d $f12, $f12, $f0
	jr $ra