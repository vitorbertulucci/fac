.data
.text
main:
	ori $1, $0, 0x5555
	sll $1, $1, 16
	addi $1, $1, 21845
	sll $2, $1, 4
	or $3, $1, $2
	and $4, $1, $2
	xor $5 , $1, $2