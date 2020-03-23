# C�lculo de Fatorial

# Vari�veis est�ticas
	.data
	.align 0
	
str_question:	.asciiz "Digite um n�mero: "
	
# Programa
	.text
	.globl main
	
main:
	li $v0, 4		# C�digo de chamada ao sistema para imprimir uma string
	la $a0, str_question	# Argumento para ser impresso
	syscall			# Chamada ao sistema
	li $v0, 5		# C�digo de chamada ao sistema para ler um inteiro
	syscall			# Chamada ao sistema
	move $t0, $v0		# Armazena n�mero lido em $t0
	li $t1, 1		# Inicializa total com 1
	li $t2, 1		# Iterador i = 1
	
loop:
	bgt $t2, $t0, end	# Condi��o de parada - se i for maior ou igual ao valor lido
	mul $t1, $t1, $t2	# Guarda em $t1 a multiplica��o total * i
	addi $t2, $t2, 1	# Incrementa i
	j loop
	
end:
	li $v0, 1		# Carrega c�digo da chamada de sistema que imprime um inteiro
	move $a0, $t1		# Armazena valor de $t1 em $a0 para ser impressa
	syscall			# Chamada ao sistema operacional
	li $v0, 10		# C�digo da chamada de sistema que sai do programa (exit)
	syscall			# Chamada ao sistema operacional