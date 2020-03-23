# Função strcpy()

# Variáveis estáticas
	.data
	.align 0

str_question: .asciiz "Digite uma frase: "
buffer:	.space 100
str: .ascii ""

# Programa
	.text
	.globl main
	
main:
	li $v0, 4		# Código de chamada ao sistema para imprimir uma string
	la $a0, str_question	# Argumento para ser impresso
	syscall			# Chamada ao sistema
	
	li $v0, 8		# Código de chamada ao sistema para ler uma string
	la $a0, buffer		# Espaço reservado na memória
	li $a1, 100		# Quantidade de bytes que deixa string ter
	move $t0, $a0		# Armazena string lida em $t0
	syscall			# Chamada ao sistema
	
	move $t1, $0		# Iterador i = 0
	la $t2, str		# Carrega em $t2 o endereço onde vai ser armazenada a string copiada
	
loop:
	bge $t1, 100, end	# Condição de parada -> se i maior ou igual a 100 -> end
	
	lb $t3, 0($t0)		# Carrega em $t3 os bytes da frase digitada (um a cada iteração do loop)
	sb $t3, 0($t2)		# Salva os bytes no endereço de $t2
	
	addi $t1, $t1, 1	# Incrementa i
	addi $t0, $t0, 1	# Vai para a próxima posição da string
	addi $t2, $t2, 1
	
	j loop
	
end:
	la $a0, str		# Carrega endereço do começo da nova string
	li $v0, 4		# Código de chamada ao sistema para imprimir uma string
	syscall			# Chamada ao sistema
	
	li $v0, 10		# Código da chamada de sistema que sai do programa (exit)
	syscall			# Chamada ao sistema operacional