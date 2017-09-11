.data
	size:	.word	8	# tamanho do array
	array:	.word	23, -12, 45, -32, 52, -72, 8, 13	# array a ser percorrido
.text
	lw $t0, size		# carrega o tamanho
	la $a0, array		# carrega o endereço do array
	lw $t7, 0($a0)		# carrega o primeiro elemento do array
	or $t1, $0, $t7		# iguala o menor como sendo o primeiro elemento do array
	or $t2, $0, $t7		# iguala o maior como sendo o primeiro elemento do array
	j loop			# chama o loop
	
loop:
	addi $t0, $t0, -1		# diminui 1 do tamanho
	bltz $t0, end			# se percorreu todo o array, finaliza
	lw $t3, 0($a0)			# carrega o primeiro elemento do array
	blt $t3, $t1, addSmall		# se for menor que o menor, modifica o menor
	bgt $t3, $t2, addGreater	# se for maior que o maior, modifica o maior
	addi $a0, $a0, 4		# desloca a memória do array em 4 bytes (pega o próximo elemento)
	j loop				# chama o loop
	
addSmall:
	add $t1, $0, $t3	# modifica o menor
	addi $a0, $a0, 4	# desloca a memória do array
	j loop			# chama o loop
	
addGreater:
	add $t2, $0, $t3	# modifica o maior
	addi $a0, $a0, 4	# desloca a memória do array
	j loop			# chama o loop
	
end:
	li $v0, 10
	syscall