# SSC0902 – Organização e Arquitetura de Computadores
# 1ª Trabalho Prático - Calculadora

# 11218963 - Ana Luisa Teixeira Costa
# 11218809 - Flavio Salles
# 11275130 - Otto Cruz Fernandes
# 11219004 - Yasmin Osajima de Araujo

# Variáveis estáticas
	.data
	.align 0

opt_menu:	.asciiz "\n\t\tMENU\n\n1 - Soma de 2 números (2 parâmetros)\n2 - Subtração de 2 números (2 parâmetros)\n3 - Multiplicação de 2 números, limitados a 16 bits cada um (2 parâmetros)\n4 - Divisão de 2 números, limitados a 16 bits cada um (2 parâmetros)\n5 - Potência (2 parâmetros)\n6 - Raiz quadrada (1 parâmetro)\n7 - Tabuada de 1 número fornecido (1 parâmetro)\n8 - Cálculo do IMC (Índice de Massa Corporal) (2 parâmetros)\n9 - Fatorial de 1 número fornecido (1 parâmetro)\n10 - Cálculo da sequência de Fibonacci até um dado número fornecido pelo usuário (1 parâmetro)\n11 - Encerrar o programa\n\nSelecione uma opção: "
str_fibonacci:	.asciiz "Digite um número para o cálculo de fibonacci: "
enter:		.asciiz "\n"
espaco:		.asciiz " "

# Programa
	.text
	.globl main
	
main:
	li $v0, 4			# Código de chamada ao sistema para imprimir uma string
	la $a0, opt_menu		# Carrega endereço do começo da string a ser impressa
	syscall
	
	li $v0, 5			# Código de chamada ao sistema para ler um inteiro
	syscall				# Chamada ao sistema
	move $t0, $v0			# Armazena número lido em $t0
	
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
	
	j main				# Caso opção selecionada não esteja no menu, pede para usuário digitar novamente
	
sum:

subtraction:

multiplication:

division:

exponentiation:

square_root:

times_table:

imc:

factorial:

# Cálculo da sequência de Fibonacci até um dado número fornecido pelo usuário (1 parâmetro)
fibonacci:
	li $v0, 4			# Código de chamada ao sistema para imprimir uma string
	la $a0, str_fibonacci		# Carrega endereço do começo da string a ser impressa
	syscall				# Chamada ao sistema operacional
	
	li $v0, 5			# Código de chamada ao sistema para ler um inteiro
	syscall				# Chamada ao sistema
	move $a3, $v0			# Armazena número lido em $a3, como parâmtro pra função
	
	li $a1, 0			# Carrega $a1 = 0 -> será o primeiro valor pra soma da seq. de fibonacci
	li $a2, 1 			# Carrega $a2 = 1 -> será o segundo valor
	
	
	addi $a3, $a3, -1		# Subtrai 1 de $a3 para o primeiro 1 da sequencia
	
	ble $a3, $0, fib_return		# Condição - caso seja um número inválido ( menor ou igual a zero) -> encerra operação
	
	li $a0, 1			# Carrega o primeiro 1 da seq. para ser impresso
	li $v0, 1			# Código de chamada ao sistema para imprimir um inteiro
	syscall				# Chamada ao sistema operacional
	
	li $v0, 4			# Código de chamada ao sistema para imprimir uma string
	la $a0, espaco			# Imprime um espaço pra melhor formatação da resposta
	syscall				# Chamada ao sistema operacional
	
	jal fib_rec			# Desvia pro procedimento e armazena end. de retorno em $ra
	
	li $v0, 4			# Código de chamada ao sistema para imprimir uma string
	la $a0, enter			# Imprime um enter pra melhor formatação da resposta
	syscall				# Chamada ao sistema operacional
	
	j main				# Volta para o menu
	
fib_rec:
	addi $sp, $sp, -16		# Move $sp 16 bytes adiante na stack
	sw $ra, 0($sp)			# Salva registradores na stack nos 16 bytes reservados
	sw $a1, 4($sp)			
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	
	ble $a3, $0, fib_return		# Condição de parada - se $a3 chegar em 0 -> fib_return
	
	addi $a3, $a3, -1		# Decrementa $a3 - $a3 é controle de qtd de elementos na seq
			
	add $a0, $a1, $a2		# Calcula próx valor da seq. e armazena em $a0 para imprimir
	move $a1, $a2			# Atualiza valores para próximos 2 da sequencia
	move $a2, $a0
	li $v0, 1			# Código de chamada ao sistema para imprimir um inteiro
	syscall				# Chamada ao sistema operacional
	
	li $v0, 4			# Código de chamada ao sistema para imprimir uma string
	la $a0, espaco			# Imprime um espaço pra melhor formatação da resposta
	syscall				# Chamada ao sistema operacional
	
	jal fib_rec			# Desvia pro procedimento e armazena end. de retorno em $ra

	
	
fib_return:
	lw $ra, 0($sp)			# Desempilha valor de $ra da stack
	addi $sp, $sp, 16		# Volta $sp 16 bytes
	
	jr $ra				# Desvia para endereço guardado em $ra

# Encerrar o programa
exit:
	li $v0, 10			# Código da chamada de sistema que sai do programa (exit)
	syscall				# Chamada ao sistema operacional
