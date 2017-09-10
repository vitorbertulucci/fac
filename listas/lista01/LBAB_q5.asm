.data
.text
main:
	ori $1, $0, 0x0000FACE
	ori $7, $0, 0x00000000
	srl $3, $1, 12
	sll $3, $3, 4
	or $2, $3, $1
	srl $3, $3, 12