.data
    buffer: 	.space	16 	# limita o tamanho máximo da string de entrada para 16 bytes
    str1:  	.asciiz "Digite uma string de ate 16 bytes:\n"
    str2:  	.asciiz "Seu resultado eh:\n"
    const: 	.word	0xEDB88320	# mascara a ser utilizada para calcular o crc32
    mask: 	.word 	0x00
    crc: 	.word 	0xFFFFFFFF 	# início do crc32
.text

main:
	addi $s0, $0, 0x00000000
	addi $s1, $0, 0xFFFFFFFF
	addi $s3, $0, 0xEDB88320 
	la $a0, str1    # Load and print string asking for string
	li $v0, 4
	syscall
	jal read_string
	j compute_crc32

read_string:
    li $v0, 8       # take in input
    la $a0, buffer  # load byte space into address
    li $a1, 20      # allot the byte space for string
    move $t0, $a0   # save string to t0
    syscall
    jr $ra
    
compute_crc32:
	li $s2, 7				# variavel do contador do fora ---------------------------> OK
	lbu $t4, ($t0) 			# le o primeiro byte da string (chamaremos $t4 de byte) --> OK
	beqz $t4, print_result	# se o byte == 0, imprime resultado
	xor $s1, $t4, $s1 		# crc = crc xor byte -------------------------------------> OK
	jal loop
	add $t0, $t0, 1			# shift de 4 bits na string (para pegar o proximo caracter)
	j compute_crc32
	
loop:
	bltz $s2, return
	andi $s0, $s1, 0x01	# mask = crc and 1 -------------------------------------------> OK
	mul $s0, $s0, -1	# mask = -mask	   -------------------------------------------> OK
	srl $s1, $s1, 1		# crc = crc >> 1   -------------------------------------------> OK
	and $t6, $s0, $s3	# t6 = (const and mask)
	xor $s1, $t6 $s1 	# crc = crc xor t6
	subi $s2, $s2, 1
	j loop

return:
	jr $ra

print_result:
	li $v0, 10
	syscall
    la $a0, str2    # load and print "you wrote" string
    li $v0, 4
    syscall

print_string:
    la $a0, buffer  # reload byte space to primary address
    move $a0, $t0   # primary address = t0 address (load pointer)
    li $v0, 4       # print string
    syscall

end:
    li $v0, 10      # end program
    syscall
