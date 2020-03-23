# Fun��o strcat()

# Vari�veis est�ticas
	.data
	.align 0

str_question: .asciiz "Digite uma frase: "
buffer:	.space 100
str: .ascii "Voc� digitou: "

# Programa
	.text
	.globl main
	
main:
	li $v0, 4		# C�digo de chamada ao sistema para imprimir uma string
	la $a0, str_question	# Argumento para ser impresso
	syscall			# Chamada ao sistema
	
	li $v0, 8		# C�digo de chamada ao sistema para ler uma string
	la $a0, buffer		# Espa�o reservado na mem�ria
	li $a1, 100		# Quantidade de bytes que deixa string ter
	move $t0, $a0		# Armazena string lida em $t0
	syscall			# Chamada ao sistema
	
	move $t1, $0		# Iterador i = 0
	
	la $t2, str		# Carrega em $t2 o endere�o onde vai ser armazenada a string copiada
	
	lb $t4, 0($t2)
	
loop_end_str:			# Posiciona registrador no final da string p/ poder concatenar
	beq $t4, '\0', loop	# Condi��o de parada -> quando $t4 tem \0 -> loop
	addi $t2, $t2, 1	# Vai para pr�xima posi��o da string (letra)
	lb $t4, 0($t2)		# Carrega byte para $t4
	j loop_end_str
	
loop:
	bge $t1, 100, end	# Condi��o de parada -> se i maior ou igual a 100 -> end
	
	lb $t3, 0($t0)		# Carrega em $t3 os bytes da frase digitada (um a cada itera��o do loop)
	sb $t3, 0($t2)		# Salva os bytes no endere�o de $t2 (no final da str)
	
	addi $t1, $t1, 1	# Incrementa i
	addi $t0, $t0, 1	# Vai para a pr�xima posi��o da string
	addi $t2, $t2, 1
	
	j loop
	
end:
	la $a0, str		# Carrega endere�o do come�o da nova string concatenada
	li $v0, 4		# C�digo de chamada ao sistema para imprimir uma string
	syscall			# Chamada ao sistema
	
	li $v0, 10		# C�digo da chamada de sistema que sai do programa (exit)
	syscall			# Chamada ao sistema operacional