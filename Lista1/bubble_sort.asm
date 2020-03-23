# Bubble Sort

# Variáveis estáticas
	.data
	.align 2
	
num:	.word 7, 5, 2, 1, 1, 3, 4

# Programa
	.text
	.globl main
	
main:
	li $t1, 7		# Define máx (tamanho do vetor)
	li $t2, -1		# i = -1 -> iterador loop externo
	
outer_loop:
	bge $t2, $t1, end_loop	# Condição de parada -> se i maior ou igual a max - sai do loop
	addi $t2, $t2, 1	# Incrementa i
	la $t0, num		# Carrega endereço inicial do vetor
	li $t3, 6		# j = max-1 -> iterador loop interno
	
inner_loop:
	ble $t3, $2, outer_loop	# Condição de parada -> se j menor ou igual a i - 
	lw $t4, 24($t0)		# Carrega em $t4 a posição armazenada em (4*6)+$t0(num)
	lw $t5, 20($t0)		# Carrega em $t5 a posição anterior a $t4
	addi $t3, $t3, -1	# Decrementa j
	addi $t0, $t0, -4	# Volta uma posição no vetor num
	bgt $t5, $t4, swap	# Caso $t5 seja maior que $t4, inverte os valores
	j inner_loop

swap:
	sw $t5, 28($t0)		# Armazena valores na posição invertida
	sw $t4, 24($t0)
	j inner_loop

end_loop:
	la $t0, num		# Redefine $t0 como endereço inicial do vetor
	li $t2, 0		# Redefine i = 0
	li $v0, 1		# Carrega código da chamada de sistema que imprime um inteiro
	
print_loop:
	bge $t2, $t1, end	# Condição de parada -> se i maior ou igual max - termina o programa
	lw $t4, 0($t0)		# Redefine $t4 com o primeiro valor armazenado em $t0
	move $a0, $t4		# Armazena valor de $t4 em $a0 para ser impressa
	syscall			# Chamada ao sistema
	addi $t0, $t0, 4	# Avança uma posição no vetor num
	addi $t2, $t2, 1	# Incrementa i
	j print_loop
		
end:
	li $v0, 10		# Código da chamada de sistema que sai do programa (exit)
	syscall			# Chamada ao sistema operacional