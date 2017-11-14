.data
    buffer: 	.space	16 	# limita o tamanho máximo da string de entrada para 16 bytes
    str1:  	.asciiz "Digite uma string de ate 16 bytes:\n"
    str2:  	.asciiz "Seu resultado eh:\n"
    const: 	.word	0xEDB88320	# mascara a ser utilizada para calcular o crc32
    mask: 	.word 	0x00
    crc: 	.word 	0xFFFFFFFF 	# início do crc32
    count:	.word	7		# variavel auxiliar
.text

main:
	la $s0, mask
	la $s1, crc
	la $s2, count
	la $s3, const
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
	lb $t4, ($t0) 	# le o primeiro byte da string (chamaremos $t4 de byte)
	beqz $t4, print_result
	xor $s1, $s1, $t4 	# crc = crc xor byte
	jal loop
	sll $t0, $t0, 4		# shift de 4 bytes na string (para pegar o proximo caracter)
	j compute_crc32
	
loop:
	bltz $s2, return
	andi $s0, $s1, 1	# mask = crc and 1
	mul $s0, $s0, -1	# mask = -mask
	sll $s1, $s1, 4		# crc = crc >> 1
	and $t6, $s3, $s0	# t6 = (const and mask)
	xor $s1, $s1, $t6 	# crc = crc xor t6
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
