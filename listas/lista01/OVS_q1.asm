.data
	string:	.asciiz	"ABCDEFG"
.text
main:
	la $a0, string	# pega o endereco da string
	j loop		# chama o loop
	
loop:
	
	lb $t1, 0($a0)		# carrega o primeiro caracter da string
	beqz $t1, end		# se for zero (fim da string) encerra o programa
	ori $t1, $t1, 0x20	# adiciona imediato 0x20 no byte de caracter
	sb $t1, 0($a0)		# sobrescreve o byte lido
	addi $a0, $a0, 1	# adiciona 1 no endereço de memória em $a0 para pegar o próximo byte
	j loop			# executa novamente o loop
	
end:
	li $v0, 10
	syscall
	