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
str_sum:	.asciiz "Digite dois números para somar: \n"
str_sub:	.asciiz "Digite dois números para subtrair: \n"
str_mul:	.asciiz "Digite dois números para multiplicar: \n"
str_div:	.asciiz "Digite dois números para dividir: \n"
str_sqrt:	.asciiz "Digite um número para calcular a raiz quadrada: "
str_times:	.asciiz "Digite um número para calcular sua tabuada: "
str_imc:	.asciiz "Digite seu peso e sua altura(em centímetros) para o cálculo do seu IMC (índice de massa comporal): \n"
str_fatorial:   .asciiz "Digite um número que deseja calcular seu fatorial: "
str_exponencial: .asciiz "Digite dois números que deseja calcular a potencia (primeiero elevado ao segundo) \n"
str_error:       .asciiz "Impossível calcular, digite valores válidos\n "
enter:		.asciiz "\n"
espaco:		.asciiz " "
	
	.align 2

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
	li $v0 4			# Imprimindo a mensagem para que o usuário digite
	la $a0 str_sum
	syscall
	
	li $v0 5			# Lendo os dois valores do usuário
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
	li $v0 4			# Imprimindo a mensagem para que o usuário digite
	la $a0 str_sub
	syscall
		
	li $v0 5			# Lendo os dois valores do usuário
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
	li $v0 4			# Imprimindo a mensagem para que o usuário digite
	la $a0 str_mul
	syscall
	
	li $v0 5			# Lendo os dois valores do usuário
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
	li $v0 4			# Imprimindo a mensagem para que o usuário digite
	la $a0 str_div
	syscall
	
	li $v0 5			# Lendo os dois valores do usuário
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
	li $v0, 4			# Imprimindo a mensagem para que o usuário digite
	la $a0, str_exponencial
	syscall
	
	li $v0, 5			# Lendo os dois valores do usuário
	syscall
	move $t0, $v0
	
	li $v0, 5
	syscall
	move $t1, $v0

	blt $t1, 0, error 		# Checa se esta sendo elevado por algum número negativo	
	
	beq $t1, 0, elevado0		# Caso seja elevado a 0
	
	move $t2, $t0			# Salvando o numero que sera elevado 
	
	li $t3, 1			# Caso de parada
	
loop_exponencial:
	beq $t3, $t1, endloop		# Quando o número foi multiplicado n vezes
	
	mul $t0, $t0, $t2		# Multiplicando o último valor da multiplicação pela base
	
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
	li $v0 4			# Imprimindo a mensagem para que o usuário digite
	la $a0 str_sqrt
	syscall
	
	li $v0 5			# Lendo o valor do usuário
	syscall
	move $s0 $v0
	
	blt $s0, 0, error 		# Caso o valor seja menor que zero
	
	move $s1 $s0 			# Copiando o valor para o registrador $s1
	
	li $s2 2			# Obtendo a metade do valor do usuário
	div $s2 $s0 $s2 		# Esse será o número de vezes que faremos a iteração
	
	li $s3 0 			# i = 0
	
	li $t1 2			# $t1 <- 2, que será usado dentro do loop
	
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
	li $v0 4			# Imprimindo a mensagem para que o usuário digite
	la $a0 str_times
	syscall
	
	li $v0 5			# Lendo um valor do usuário
	syscall
	move $s0 $v0
	li $v0 4
	la $a0 enter
	syscall
	
	li $s1, 0			# Inicializa o multiplicador com 0
	
loop:	
	mul $a0, $s0, $s1		# Realiza a multiplicação

	li $v0 1			# Imprimindo o resultado
	syscall
	li $v0 4
	la $a0 enter
	syscall
 			 		
	addi, $s1, $s1, 1	 	# Incrementa o multiplicador	
	
	ble $s1, 10, loop 		# Continua no loop até que multiplicador seja igual a 10
	
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
	li $v0, 4			# Calculando o fatorial de um número
	la $a0, str_fatorial
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	blt $t0, 0, error
	
	move $a0, $t0			# Passa o número para ser calculado como parametro e chama a função recursiva
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
	

	jal fatorial_rec		# Chama novamente a recursão caso não tenha acontecido o caso de parada
	
	addi $a0, $a0, 1        	# Adiciona 1 ao $a0
	mul $v0, $v0 , $a0      	# Multiplica o valor de retorno da função recursiva pelo $a0
	
	j retornafat 
	
retorna1:
	li $v0 , 1			# Salva 1 em $v0 para começar a multiplicação
	
retornafat:
	lw $a0, 0($sp) 			# Lê os valores que estão na pilha	
	lw $ra, 4($sp)
	
	addi $sp, $sp, 8 		# Move o ponteiro da pilha para onde estava anteriormente
	
	jr $ra				# Volta para a onde a função foi chamada
	

# Cálculo da sequência de Fibonacci até um dado número fornecido pelo usuário (1 parâmetro)
fibonacci:
	li $v0, 4			# Código de chamada ao sistema para imprimir uma string
	la $a0, str_fibonacci		# Carrega endereço do começo da string a ser impressa
	syscall				# Chamada ao sistema operacional
	
	li $v0, 5			# Código de chamada ao sistema para ler um inteiro
	syscall				# Chamada ao sistema
	move $a3, $v0			# Armazena número lido em $a3, como parâmtro pra função
	
	ble $a3, 0, error		# Condição - caso seja um número inválido ( menor ou igual a zero) -> encerra operação
	
	li $a1, 0			# Carrega $a1 = 0 -> será o primeiro valor pra soma da seq. de fibonacci
	li $a2, 1 			# Carrega $a2 = 1 -> será o segundo valor
	
	
	addi $a3, $a3, -1		# Subtrai 1 de $a3 para o primeiro 1 da sequencia
	
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
	addi $sp, $sp, -4		# Move $sp 4 bytes adiante na stack
	sw $ra, 0($sp)			# Salva registrador na stack nos 4 bytes reservados
	
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
	addi $sp, $sp, 4		# Volta $sp 16 bytes
	
	jr $ra				# Desvia para endereço guardado em $ra



# Caso ocorra algum erro
error:
	li $v0, 4
	la $a0, str_error
	syscall
	
	j main



# Encerrar o programa
exit:
	li $v0, 10			# Código da chamada de sistema que sai do programa (exit)
	syscall				# Chamada ao sistema operacional
