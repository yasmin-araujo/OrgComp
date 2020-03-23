# Fun��o strcmp()

# Vari�veis est�ticas
	.data
	.align 0

str_question: .asciiz "Digite uma frase: "
buffer:	.space 100
buffer2: .space 100
str_yes: .asciiz "S�o iguais"
str_no: .asciiz "N�o s�o iguais"

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
	
	li $v0, 4		# C�digo de chamada ao sistema para imprimir uma string
	la $a0, str_question	# Argumento para ser impresso
	syscall			# Chamada ao sistema
	
	li $v0, 8		# C�digo de chamada ao sistema para ler uma string
	la $a0, buffer2		# Espa�o reservado na mem�ria
	li $a1, 100		# Quantidade de bytes que deixa string ter
	move $t1, $a0		# Armazena string lida em $t1
	syscall			# Chamada ao sistema
	
loop_cmp:
	lb $t2, 0($t0)		# Le byte da primeira string
	lb $t3, 0($t1)		# Le byte da segunda string
	addi $t0, $t0, 1	# Avan�a no array
	addi $t1, $t1, 1
	bne $t2, $t3, no	# Condi��o de parada -> se bytes forem diferentes -> no
	beq $t2, '\0', yes	# Condi��o de parada -> (ambas s�o iguais) se strings acabaram juntas (mesmo tamanho) -> yes
	j loop_cmp

yes:
	la $a0, str_yes		# Carrega endere�o da mensagem de igualdade
	j end

no:
	la $a0, str_no		# Carrega endere�o da mensagem de n�o igualdade
	
end:
	li $v0, 4		# C�digo de chamada ao sistema para imprimir uma string
	syscall			# Chamada ao sistema
	li $v0, 10		# C�digo da chamada de sistema que sai do programa (exit)
	syscall			# Chamada ao sistema operacional