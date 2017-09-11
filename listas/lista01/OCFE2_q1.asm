.data
	max:	.word	100
	
.text
main:
	lw $a0, max		# carrega o max
	ori $t1, $0, 0		# inicia o contador em 0
	ori $t2, $0, 0		# coloca 1 no valor
	j loop			# chama o loop
	
loop:
	beq $t1, $a0, end	# se contador = max, finaliza
	addi $t1, $t1, 1	# incrementa contador
	addi $t2, $t2, 1	# adiciona unsigned t2 = t2 + contador
	addu $t3, $t3, $t2	# result = result + valor
	j loop			# loop dnv
	
end:
	li $v0, 10
	syscall
