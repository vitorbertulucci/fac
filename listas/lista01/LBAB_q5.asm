.data
.text
main:
	ori $1, $0, 0x00001234	# inicia o registrador 1
	ori $2, $0, 0x0000F000	# inicia o registrador 2 para ser utilizado para receber os bits
	ori $3, $0, 8		# inicia o registrador 3 para ser o deslocador de bits
	and $4, $1, $2		# pega o F do registrador 1 e coloca no 4
	srlv $2, $2, $3		# desloca o registrador 4 em 2 bytes
	and $5, $2, $1		# pega o C do registrador 1 e coloca no 5, por meio da mascara
	sllv $5, $5, $3		# desloca o registrador 5 em 2 bytes para a esquerda = 0xc000
	srlv $4, $4, $3
	or $6, $5, $4		# junta o C e o F em um registrador $6 = 0xc0f0
	srlv $5, $5, $3		# desloca o registrador 5 em 2 bytes para a direita = 0x00c0
	sllv $4, $4, $3
	or $7, $5, $4		# junta o F com o C em um só registrador = 0xf0c0
	xor $8, $1, $7		# pega só o que é diferente entre os regisradores 1 e 7 = 0x0a0e
	or $2, $8, $6		# junta o registrador 6 com o 8 = 0xcafe