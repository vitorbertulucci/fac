.data

.text
main:
	ori $1, $0, 0x00000000
	addi $1, $1, 456
	subi $1, $1, 229
	addi $1, $1, 325
	subi $1, $1 , 552
	or $8, $0, $1
	li $v0, 10
	syscall