.data
.text
main:
	ori $8, $0, 0x0029
	sll $8, $8, 16
	ori $8, $8,0x8D7D	# valor a ser contado
	ori $7, $0, 0		# valor do shift
	j loop			# pula pro loop
loop:
	addi $7, $7, 1		# incrementa o shift para iniciar do 31
	srlv $9, $8, $7		# pega o valor do shift e coloca em $9
	bnez $9, loop		# se o valor do 9 não for zero, chama loop 
	
end:
	li $v0, 10
	syscall