# Inverter dígitos de número positivo inteiro até 999

# Variáveis estáticas
	.data
	.align 0
	
str_question:	.asciiz "Digite um número: "

# Programa
	.text
	.globl main
	
main:
	li $v0, 4		# Código de chamada ao sistema para imprimir uma string
	la $a0, str_question	# Argumento para ser impresso
	syscall			# Chamada ao sistema
	li $v0, 5		# Código de chamada ao sistema para ler um inteiro
	syscall			# Chamada ao sistema
	move $t0, $v0		# Armazena valor lido em $t0
	li $v0, 1		# Código de chamada ao sistema para imprimir um inteiro
	
	# Primeiro dígito
	div $t1, $t0, 100	# Divide $t0 por 100 e pega primeiro dígito em $t1
	
	# Segundo digito
	div $t2, $t0, 10	# Divide número por 10 e pega 2 primeiros dígitos em $t2
	mul $t4, $t1, -10	# Multiplica primeiro digito por 10 e armazena na aux $t4
	add $t2, $t2, $t4	# Subtrai $t4 de $t2
	
	# Terceito digito
	mul $t4, $t4, -1	# Transforma $t4 em positivo
	add $t4, $t4, $t2	# Soma $t4 e $t2 em $t4
	mul $t4, $t4, -10	# Transforma $t4 em positivo
	add $t3, $t0, $t4	# Subtrai $t4 de $t3
	
	move $a0, $t3 		# Carrega o valor de $t3 em $a0 para ser impresso
	syscall			# Chamada ao sistema
	
	add $t5, $t1, $t2	# Variável aux $t5 é soma dos 2 primeiros dígitos
	beqz $t5, end		# Se soma = 0 -> end
	
	move $a0, $t2 		# Carrega o valor de $t2 em $a0 para ser impresso
	syscall			# Chamada ao sistema
	
	beqz $t1, end		# Se $t1 = 0 -> end
	move $a0, $t1 		# Carrega o valor de $t1 em $a0 para ser impresso
	syscall			# Chamada ao sistema
	
end:
	li $v0, 10		# Código da chamada de sistema que sai do programa (exit)
	syscall			# Chamada ao sistema operacional
	