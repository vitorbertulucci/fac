.data
primo: 		.word 		0			 		# primeiro numero a ser lido
numero: 	.word 		0					# segundo numero a ser lido
string1: 	.asciiz 	"O inverso multiplicativo eh "		# string para mostrar o resultado da operação
string2: 	.asciiz		"O modulo nao eh primo"			# string para mostrar que não é primo

.text
main:
	la $a0, primo		# armazena o endereço de memória de number1 em $a0
	la $a1, numero		# armazena o endereço de memória de number2 em $a1
	jal le_inteiros		# pula para o local de memória "le_inteiros" esperando o seu retorno
	jal eh_primo		# pula para o local de memória "eh_primo" esperando o seu retorno
	
le_inteiros:
	li $v0, 5		# carrega 5 em $v0 para chamar a função de read Integer
	syscall			# executa a chamada da função
	la $t0, 0($v0)		# armazena o valor lido em $t0
	li $v0, 5
	syscall
	la $t1, ($v0)		# armazena o valor lido em $t1
	sw $t0, ($a0)		# armazena o valor de $t0 no local de memória de $a0 (variável 'primo')
	sw $t1, ($a1)		# armazena o valor de $t1 no local de memória de $a1 (variável 'numero')
	jr $ra			# retorna para a função que o chamou
	
eh_primo:
	