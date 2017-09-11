.data
	max:	.word	100
	max2:	.word	99
	
.text
main:
	lw $a0, max		# carrega o max
	lw $a1, max2		# carrega o max2
	ori $t1, $0, 0		# inicia o contador em 0
	ori $t2, $0, 0		# coloca 1 no valor
	ori $t4, $0, 1
	j loop			# chama o loop
	
loop:
	beq $t2, $a0, loop2	# se contador = max, finaliza
	addi $t2, $t2, 1	# adiciona 1 ao valor
	addu $t3, $t3, $t2	# result = result + valor
	j loop			# loop dnv
	
loop2: 
	beq $t4, $a1, end	# se contador = max, finaliza
	addi $t4, $t4, 2	# adiciona 1 ao valor
	addu $8, $8, $t2	# result = result + valor
	j loop2			# loop dnv

end:
	li $v0, 10
	syscall
