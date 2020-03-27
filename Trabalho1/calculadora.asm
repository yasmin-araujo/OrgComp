# SSC0902 � Organiza��o e Arquitetura de Computadores
# 1� Trabalho Pr�tico - Calculadora

# 11218963 - Ana Luisa Teixeira Costa
# 11218809 - Flavio Salles
# 11275130 - Otto Cruz Fernandes
# 11219004 - Yasmin Osajima de Araujo

# Vari�veis est�ticas
	.data
	.align 0

opt_menu:	.asciiz "\n\t\tMENU\n\n1 - Soma de 2 n�meros (2 par�metros)\n2 - Subtra��o de 2 n�meros (2 par�metros)\n3 - Multiplica��o de 2 n�meros, limitados a 16 bits cada um (2 par�metros)\n4 - Divis�o de 2 n�meros, limitados a 16 bits cada um (2 par�metros)\n5 - Pot�ncia (2 par�metros)\n6 - Raiz quadrada (1 par�metro)\n7 - Tabuada de 1 n�mero fornecido (1 par�metro)\n8 - C�lculo do IMC (�ndice de Massa Corporal) (2 par�metros)\n9 - Fatorial de 1 n�mero fornecido (1 par�metro)\n10 - C�lculo da sequ�ncia de Fibonacci at� um dado n�mero fornecido pelo usu�rio (1 par�metro)\n11 - Encerrar o programa\n\nSelecione uma op��o: "
str_fibonacci:	.asciiz "Digite um n�mero para o c�lculo de fibonacci: "
enter:		.asciiz "\n"
espaco:		.asciiz " "

# Programa
	.text
	.globl main
	
main:
	li $v0, 4			# C�digo de chamada ao sistema para imprimir uma string
	la $a0, opt_menu		# Carrega endere�o do come�o da string a ser impressa
	syscall
	
	li $v0, 5			# C�digo de chamada ao sistema para ler um inteiro
	syscall				# Chamada ao sistema
	move $t0, $v0			# Armazena n�mero lido em $t0
	
	beq $t0, 1, sum			# Condicionais para direcionar programa pra funcionalidade certa 
	beq $t0, 2, subtraction		# dependendo do valor lido e armazenado em $t0
	beq $t0, 3, multiplication
	beq $t0, 4, division
	beq $t0, 5, exponentiation
	beq $t0, 6, square_root
	beq $t0, 7, times_table
	beq $t0, 8, imc
	beq $t0, 9, factorial
	beq $t0, 10, fibonacci
	beq $t0, 11, exit
	
	j main				# Caso op��o selecionada n�o esteja no menu, pede para usu�rio digitar novamente
	
sum:

subtraction:

multiplication:

division:

exponentiation:

square_root:

times_table:

imc:

factorial:

# C�lculo da sequ�ncia de Fibonacci at� um dado n�mero fornecido pelo usu�rio (1 par�metro)
fibonacci:
	li $v0, 4			# C�digo de chamada ao sistema para imprimir uma string
	la $a0, str_fibonacci		# Carrega endere�o do come�o da string a ser impressa
	syscall				# Chamada ao sistema operacional
	
	li $v0, 5			# C�digo de chamada ao sistema para ler um inteiro
	syscall				# Chamada ao sistema
	move $a3, $v0			# Armazena n�mero lido em $a3, como par�mtro pra fun��o
	
	li $a1, 0			# Carrega $a1 = 0 -> ser� o primeiro valor pra soma da seq. de fibonacci
	li $a2, 1 			# Carrega $a2 = 1 -> ser� o segundo valor
	
	
	addi $a3, $a3, -1		# Subtrai 1 de $a3 para o primeiro 1 da sequencia
	
	ble $a3, $0, fib_return		# Condi��o - caso seja um n�mero inv�lido ( menor ou igual a zero) -> encerra opera��o
	
	li $a0, 1			# Carrega o primeiro 1 da seq. para ser impresso
	li $v0, 1			# C�digo de chamada ao sistema para imprimir um inteiro
	syscall				# Chamada ao sistema operacional
	
	li $v0, 4			# C�digo de chamada ao sistema para imprimir uma string
	la $a0, espaco			# Imprime um espa�o pra melhor formata��o da resposta
	syscall				# Chamada ao sistema operacional
	
	jal fib_rec			# Desvia pro procedimento e armazena end. de retorno em $ra
	
	li $v0, 4			# C�digo de chamada ao sistema para imprimir uma string
	la $a0, enter			# Imprime um enter pra melhor formata��o da resposta
	syscall				# Chamada ao sistema operacional
	
	j main				# Volta para o menu
	
fib_rec:
	addi $sp, $sp, -16		# Move $sp 16 bytes adiante na stack
	sw $ra, 0($sp)			# Salva registradores na stack nos 16 bytes reservados
	sw $a1, 4($sp)			
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	
	ble $a3, $0, fib_return		# Condi��o de parada - se $a3 chegar em 0 -> fib_return
	
	addi $a3, $a3, -1		# Decrementa $a3 - $a3 � controle de qtd de elementos na seq
			
	add $a0, $a1, $a2		# Calcula pr�x valor da seq. e armazena em $a0 para imprimir
	move $a1, $a2			# Atualiza valores para pr�ximos 2 da sequencia
	move $a2, $a0
	li $v0, 1			# C�digo de chamada ao sistema para imprimir um inteiro
	syscall				# Chamada ao sistema operacional
	
	li $v0, 4			# C�digo de chamada ao sistema para imprimir uma string
	la $a0, espaco			# Imprime um espa�o pra melhor formata��o da resposta
	syscall				# Chamada ao sistema operacional
	
	jal fib_rec			# Desvia pro procedimento e armazena end. de retorno em $ra

	
	
fib_return:
	lw $ra, 0($sp)			# Desempilha valor de $ra da stack
	addi $sp, $sp, 16		# Volta $sp 16 bytes
	
	jr $ra				# Desvia para endere�o guardado em $ra

# Encerrar o programa
exit:
	li $v0, 10			# C�digo da chamada de sistema que sai do programa (exit)
	syscall				# Chamada ao sistema operacional
