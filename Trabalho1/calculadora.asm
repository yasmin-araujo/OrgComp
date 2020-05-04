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
str_sum:	.asciiz "Digite dois n�meros para somar: \n"
str_sub:	.asciiz "Digite dois n�meros para subtrair: \n"
str_mul:	.asciiz "Digite dois n�meros para multiplicar: \n"
str_div:	.asciiz "Digite dois n�meros para dividir: \n"
str_sqrt:	.asciiz "Digite um n�mero para calcular a raiz quadrada: "
str_times:	.asciiz "Digite um n�mero para calcular sua tabuada: "
str_imc:	.asciiz "Digite seu peso e sua altura(em cent�metros) para o c�lculo do seu IMC (�ndice de massa comporal): \n"
str_fatorial:   .asciiz "Digite um n�mero que deseja calcular seu fatorial: "
str_exponencial: .asciiz "Digite dois n�meros que deseja calcular a potencia (primeiero elevado ao segundo) \n"
str_error:       .asciiz "Imposs�vel calcular, digite valores v�lidos\n "
enter:		.asciiz "\n"
espaco:		.asciiz " "
	
	.align 2

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
	li $v0 4			# Imprimindo a mensagem para que o usu�rio digite
	la $a0 str_sum
	syscall
	
	li $v0 5			# Lendo os dois valores do usu�rio
	syscall
	move $s0 $v0
	
	li $v0 5
	syscall
	move $s1 $v0
	
	add $a0 $s0 $s1			# Somando os valores
	
	li $v0 1			# Imprimindo
	syscall
	
	j main


subtraction:
	li $v0 4			# Imprimindo a mensagem para que o usu�rio digite
	la $a0 str_sub
	syscall
		
	li $v0 5			# Lendo os dois valores do usu�rio
	syscall
	move $s0 $v0
	
	li $v0 5
	syscall
	move $s1 $v0
	
	sub $a0 $s0 $s1			# Subtraindo os valores
	
	li $v0 1			# Imprimindo
	syscall
	
	j main


multiplication:
	li $v0 4			# Imprimindo a mensagem para que o usu�rio digite
	la $a0 str_mul
	syscall
	
	li $v0 5			# Lendo os dois valores do usu�rio
	syscall
	move $s0 $v0
	
	li $v0 5
	syscall
	move $s1 $v0
	
	mul $a0 $s0 $s1			# Multiplicando os valores
	
	li $v0 1			# Imprimindo
	syscall
	
	j main


division:
	li $v0 4			# Imprimindo a mensagem para que o usu�rio digite
	la $a0 str_div
	syscall
	
	li $v0 5			# Lendo os dois valores do usu�rio
	syscall
	move $s0 $v0
	
	li $v0 5
	syscall
	move $s1 $v0
	
	beq $s1, 0, error		# Caso tente dividir por zero
	
	div $a0 $s0 $s1			# Dividindo os valores
	
	li $v0 1			# Imprimindo
	syscall
	
	j main


exponentiation:
	li $v0, 4			# Imprimindo a mensagem para que o usu�rio digite
	la $a0, str_exponencial
	syscall
	
	li $v0, 5			# Lendo os dois valores do usu�rio
	syscall
	move $t0, $v0
	
	li $v0, 5
	syscall
	move $t1, $v0

	blt $t1, 0, error 		# Checa se esta sendo elevado por algum n�mero negativo	
	
	beq $t1, 0, elevado0		# Caso seja elevado a 0
	
	move $t2, $t0			# Salvando o numero que sera elevado 
	
	li $t3, 1			# Caso de parada
	
loop_exponencial:
	beq $t3, $t1, endloop		# Quando o n�mero foi multiplicado n vezes
	
	mul $t0, $t0, $t2		# Multiplicando o �ltimo valor da multiplica��o pela base
	
	addi $t1, $t1, -1
	
	j loop_exponencial

endloop:
	li $v0, 1
	move $a0, $t0
	syscall
	
	j main

elevado0:
	li $v0, 1
	li $a0, 1
	syscall
	
	j main
	
	

square_root:
	li $v0 4			# Imprimindo a mensagem para que o usu�rio digite
	la $a0 str_sqrt
	syscall
	
	li $v0 5			# Lendo o valor do usu�rio
	syscall
	move $s0 $v0
	
	blt $s0, 0, error 		# Caso o valor seja menor que zero
	
	move $s1 $s0 			# Copiando o valor para o registrador $s1
	
	li $s2 2			# Obtendo a metade do valor do usu�rio
	div $s2 $s0 $s2 		# Esse ser� o n�mero de vezes que faremos a itera��o
	
	li $s3 0 			# i = 0
	
	li $t1 2			# $t1 <- 2, que ser� usado dentro do loop
	
sqrtLoop:
	bge $s3 $s2 sqrtEndLoop 	# if(i < n/2){
	
	div $t0 $s0 $s1 		# $t0 <- n / x
	add $t0 $s1 $t0			# $t0 <- x + (n/x)
	div $s1 $t0 $t1			# x <- (x + (n/x)) / 2
	
	addi $s3 $s3 1  		# i++
	
	j sqrtLoop


sqrtEndLoop:
	li $v0 1			# Imprimindo o valor de x
	move $a0 $s1
	syscall
	
	j main


times_table:
	li $v0 4			# Imprimindo a mensagem para que o usu�rio digite
	la $a0 str_times
	syscall
	
	li $v0 5			# Lendo um valor do usu�rio
	syscall
	move $s0 $v0
	li $v0 4
	la $a0 enter
	syscall
	
	li $s1, 0			# Inicializa o multiplicador com 0
	
loop:	
	mul $a0, $s0, $s1		# Realiza a multiplica��o

	li $v0 1			# Imprimindo o resultado
	syscall
	li $v0 4
	la $a0 enter
	syscall
 			 		
	addi, $s1, $s1, 1	 	# Incrementa o multiplicador	
	
	ble $s1, 10, loop 		# Continua no loop at� que multiplicador seja igual a 10
	
	j main				# Retorna para o menu


imc:
	li $v0, 4			# Realiza o calculo do indice de massa corporal
	la $a0, str_imc
	syscall
	
	li $v0, 5			# Lendo peso
	syscall
	move $t0, $v0
	
	li $v0, 5			# Lendo altura
	syscall
	move $t1, $v0
	
	ble $t0, 0, error		# Caso peso ou altura sejam negativos
	ble $t1, 0, error
	
	mul $t2, $t1, $t1		# Calculando altura ao quadrado
	mul $t3 , $t0, 10000		# Compensando a altura em cm multiplicando a parte de cima por 10000
	div $a0, $t3, $t2		# Calculando imc (peso/altura^2)
	
	li $v0, 1			# Imprimindo resultado
	syscall
	
	j main


factorial:
	li $v0, 4			# Calculando o fatorial de um n�mero
	la $a0, str_fatorial
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	blt $t0, 0, error
	
	move $a0, $t0			# Passa o n�mero para ser calculado como parametro e chama a fun��o recursiva
	jal fatorial_rec
	
	move $t0 ,$v0 
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	j main 

fatorial_rec:
	addi $sp , $sp, -8 		# Move o ponteiro da pilha
	sw $a0 , 0($sp)			# Salva o valor de $a0 na pilha
	sw $ra , 4($sp)			# Salva o valor de $ra na pilha
	
	beq $a0, 0, retorna1		# Caso de parada
	
	addi $a0, $a0, -1
	

	jal fatorial_rec		# Chama novamente a recurs�o caso n�o tenha acontecido o caso de parada
	
	addi $a0, $a0, 1        	# Adiciona 1 ao $a0
	mul $v0, $v0 , $a0      	# Multiplica o valor de retorno da fun��o recursiva pelo $a0
	
	j retornafat 
	
retorna1:
	li $v0 , 1			# Salva 1 em $v0 para come�ar a multiplica��o
	
retornafat:
	lw $a0, 0($sp) 			# L� os valores que est�o na pilha	
	lw $ra, 4($sp)
	
	addi $sp, $sp, 8 		# Move o ponteiro da pilha para onde estava anteriormente
	
	jr $ra				# Volta para a onde a fun��o foi chamada
	

# C�lculo da sequ�ncia de Fibonacci at� um dado n�mero fornecido pelo usu�rio (1 par�metro)
fibonacci:
	li $v0, 4			# C�digo de chamada ao sistema para imprimir uma string
	la $a0, str_fibonacci		# Carrega endere�o do come�o da string a ser impressa
	syscall				# Chamada ao sistema operacional
	
	li $v0, 5			# C�digo de chamada ao sistema para ler um inteiro
	syscall				# Chamada ao sistema
	move $a3, $v0			# Armazena n�mero lido em $a3, como par�mtro pra fun��o
	
	ble $a3, 0, error		# Condi��o - caso seja um n�mero inv�lido ( menor ou igual a zero) -> encerra opera��o
	
	li $a1, 0			# Carrega $a1 = 0 -> ser� o primeiro valor pra soma da seq. de fibonacci
	li $a2, 1 			# Carrega $a2 = 1 -> ser� o segundo valor
	
	
	addi $a3, $a3, -1		# Subtrai 1 de $a3 para o primeiro 1 da sequencia
	
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
	addi $sp, $sp, -4		# Move $sp 4 bytes adiante na stack
	sw $ra, 0($sp)			# Salva registrador na stack nos 4 bytes reservados
	
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
	addi $sp, $sp, 4		# Volta $sp 16 bytes
	
	jr $ra				# Desvia para endere�o guardado em $ra



# Caso ocorra algum erro
error:
	li $v0, 4
	la $a0, str_error
	syscall
	
	j main



# Encerrar o programa
exit:
	li $v0, 10			# C�digo da chamada de sistema que sai do programa (exit)
	syscall				# Chamada ao sistema operacional
