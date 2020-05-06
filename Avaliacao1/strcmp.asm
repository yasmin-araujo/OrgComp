# Avaliação 2 - Organização e Arquitetura de Computadores
# 11219004 - Yasmin Osajima de Araujo

# Variáveis estáticas
	.data
	.align 0
	
buffer:		.space 100
buffer2: 	.space 100
str_phrase: 	.asciiz "Digite uma frase: "
str_num:	.asciiz "Digite um número: "

# Programa
	.text
	.globl main

main:

	li $v0, 4		# Código de chamada ao sistema para imprimir uma string
	la $a0, str_phrase	# Argumento para ser impresso
	syscall			# Chamada ao sistema
	
				# Leitura da primeira string
	li $v0, 8		# Código de chamada ao sistema para ler uma string
	la $a0, buffer		# Espaço reservado na memória
	li $a1, 100		# Quantidade de bytes que deixa string ter
	move $t0, $a0		# Armazena string lida em $t0
	syscall			# Chamada ao sistema
	
	li $v0, 4		# Código de chamada ao sistema para imprimir uma string
	la $a0, str_phrase	# Argumento para ser impresso
	syscall			# Chamada ao sistema
	
				# Leitura da segunda string
	li $v0, 8		# Código de chamada ao sistema para ler uma string
	la $a0, buffer2		# Espaço reservado na memória
	li $a1, 100		# Quantidade de bytes que deixa string ter
	move $t1, $a0		# Armazena string lida em $t1
	syscall			# Chamada ao sistema
	
	li $v0, 4		# Código de chamada ao sistema para imprimir uma string
	la $a0, str_num		# Argumento para ser impresso
	syscall			# Chamada ao sistema
	
				# Leitura do n
	li $v0, 5		# Código de chamada ao sistema para ler um inteiro
	syscall			# Chamada ao sistema
	move $t2, $v0		# Armazena número lido em $t2
	
	li $t3, 0		# Inicializa $t3 e $t4
	li $t4, 0
loop:
	blez $t2, end		# Condição de parada -> caso n <= 0
	lb $t3, 0($t0)		# Le byte da primeira string em $t3
	lb $t4, 0($t1)		# Le byte da segunda string em $t4
	addi $t0, $t0, 1	# Avança no array
	addi $t1, $t1, 1
	addi $t2, $t2, -1	# Decrementa o $t2 (n)
	bne $t3, $t4, end	# Condição de parada -> se bytes forem diferentes
	j loop

end:
	sub $t5, $t3, $t4	# Armazena em $t5 o valor da diferença entre $t3 e $t4
	move $a0, $t5		# Armazena valor de $t5 em $a0 para ser impressa

	li $v0, 1		# Carrega código da chamada de sistema que imprime um inteiro
	syscall			# Chamada ao sistema operacional
	
	li $v0, 10		# Código da chamada de sistema que sai do programa (exit)
	syscall			# Chamada ao sistema operacional