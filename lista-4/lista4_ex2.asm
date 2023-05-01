# Implemente em Assembly do MIPS o código abaixo, escrito em linguagem C:

# int calcula_area_quadrado (int h, int w) {
#	int area = h * w;
# 	return area;
# }
# int main (void) {
#	int a = 4;
#	int b = 10;
#	int val = calcula_area_quadrado(a, b);
# }

.data
.text
MAIN:
	li $s0, 4
	li $s1, 10
	
	move $a0, $s0
	move $a1, $s1
	
	jal CALCULA_AREA_QUADRADO
	
	li $v0, 10
	syscall

CALCULA_AREA_QUADRADO:
	mul $v0, $a0, $a1

	jr $ra