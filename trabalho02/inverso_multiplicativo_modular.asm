.data
primo: 		.word 		0			 		# primeiro numero a ser lido
numero: 	.word 		0					# segundo numero a ser lido
string1: 	.asciiz 	"O inverso multiplicativo eh "		# string para mostrar o resultado da operação
string2: 	.asciiz		"O modulo nao eh primo"			# string para mostrar que não é primo

.text
main:
	la $a0, primo			# armazena o endereço de memoria de number1 em $a0
	la $a1, numero			# armazena o endereço de memoria de number2 em $a1
	jal le_inteiros			# pula para o local de memoria "le_inteiros" esperando o seu retorno
	blt $a0, 2, imprime_erro 	# se o numero1 for menor que 2, imprime o erro
	jal eh_par			# se o número for par, imprime o erro
 	beq $a0, 2, calc_inverso 	# se o numero1 for igual a 2, calcula o inverso pois ele é primo
	jal eh_primo			# pula para o local de memoria "eh_primo" esperando o seu retorno
 	
le_inteiros:
	li $v0, 5			# carrega 5 em $v0 para chamar a função de read Integer
	syscall				# executa a chamada da função
	la $t0, 0($v0)			# armazena o valor lido em $t0
	li $v0, 5
	syscall
	la $t1, ($v0)			# armazena o valor lido em $t1
	sw $t0, ($a0)			# armazena o valor de $t0 no local de memoria de $a0 (variavel 'primo')
	sw $t1, ($a1)			# armazena o valor de $t1 no local de memoria de $a1 (variavel 'numero')
	jr $ra				# retorna para a função que o chamou
	
eh_par: 
	divu $t1, 2			# divide o número por 2 para verificar se é par
	mflo $v1			# modulo da divisão de t1/2 em $v1
	beqz $v1, imprime_erro		# t1 é par
	jr $ra				# retorna para a função que o chamou

eh_primo:
	subi $t2, $t1, 1		# t2 = t1 - 1
	div $t1, $t2			# t1/t2
  	mfhi $t3 			# resultado de t1/t2 em $t3
  	mflo $v0 			# quociente da divisão de t1/t2 em $v0
  	beqz $v0, imprime_erro
  	ori $t4, $0, 3			# começa a contagem a partir de 3, $t4 é o contador
  	j loop
 
loop:
	divu $a0, $t4			# numero/contador
	mflo $v0			# quociente da divisão a0/t4
	
	addi $t4, $t4, 2		# contador incrementa de 2 em 2
		
  	
imprime_erro:
	la $a2, string2			# armazena o endereço de memoria de string2 em $a0
	li $v0, 4			# função para imprimir string
	syscall

imprime_saida:
	li $a0, 10			# função para terminar o programa
	syscall
	
	