.data
modulo: 	.word 		0			 		# primeiro numero a ser lido
numero: 	.word 		0					# segundo numero a ser lido
string1: 	.asciiz 	"O inverso multiplicativo eh "		# string para mostrar o resultado da operação
string2: 	.asciiz		"O modulo nao eh primo"			# string para mostrar que não é primo

.text
main:
	la $s0, modulo			# armazena o endereco de memoria de number1 em $a0
	la $s1, numero			# armazena o endereco de memoria de number2 em $a1
	jal le_inteiros			# pula para o local de memoria "le_inteiros" esperando o seu retorno
	lw $s0, ($s0)			# a0 = conteudo de a0
	lw $s1, ($s1)			# a1 = conteudo de a1
	
	jal eh_primo			# pula para o local de memoria "eh_primo" esperando o seu retorno
 	
le_inteiros:
	li $v0, 5			# carrega 5 em $v0 para chamar a funcao de read Integer
	syscall				# executa a chamada da funcao
	la $t0, 0($v0)			# armazena o valor lido em $t0
	li $v0, 5
	syscall
	la $t1, ($v0)			# armazena o valor lido em $t1
	sw $t0, ($s0)			# armazena o valor de $t0 no local de memoria de $a0 (variavel 'modulo')
	sw $t1, ($s1)			# armazena o valor de $t1 no local de memoria de $a1 (variavel 'numero')
	jr $ra				# retorna para a funcao que o chamou
	
eh_par: 
	ori $t2, $0, 2			# t2 = 2
	divu $s0, $t2			# divide o numero por 2 para verificar se eh par
	mfhi $v1			# modulo da divisao de t1/2 em $v1
	beqz $v1, imprime_erro		# se o modulo for um numero par, imprime o erro
	jr $ra				# retorna para a funcao que o chamou

eh_primo:
	ori $t6, $0, 1			# contador $t6 = 1 para calcular o inverso
	blt $s0, 2, imprime_erro 	# se o modulo for menor que 2, imprime o erro
	beq $s0, 2, calc_inverso 	# se o numero1 for igual a 2, calcula o inverso pois ele eh primo
	jal eh_par			# chama a funcao de verificacao se o numero eh par
	ori $t4, $0, 3			# comeca a contagem a partir de 3, $t4 eh o contador
	
eh_primo_loop:
	bge $t4, $s0, calc_inverso	# se ja percorreu todos os valores impares e o modulo nao foi zero, o modulo eh primo
	div $s0, $t4			# modulo/contador
	mfhi $t5			# quociente da divisao de a0/t4 em t5
	beqz $t5, imprime_erro		# numero nao eh primo, entao, imprime_erro
	addi $t4, $t4, 2		# contador incrementa de 2 em 2
 	j eh_primo_loop
       	# for (i = 3; i < nb; i += 2, contar++)
       	#     if (nb % i == 0)
       	#         teste = 1;
  	
calc_inverso:
 	# int inv(int a){
 	#    int x;
  	#    for(x=1;x<=P;x++){
    	#        if((a*x)%P==1)
      	#	    return x;
  	#    }
	#}
	bgt $t6, $s1, imprime_saida 	# x > mod 
	mul $t7, $s1, $t6		# multiplica o numero pelo x e aloca em $t7
	div $t7, $s0	 		# divide o $t7 pelo mod  
	mfhi $t8
	beq $t8, 1, imprime_saida	# ((num * x) % mod == 1)
	addi $t6, $t6, 1		# incrementa o contador
	j calc_inverso 
 
imprime_saida:
	la $a0, string1			# armazena o endereco de memoria de string1 em $a0
	li $v0, 4			# funcao para imprimir string
	syscall
	la $a0, ($t6)
	li $v0, 1
	syscall
	j end
    
imprime_erro:
	la $a0, string2			# armazena o endereco de memoria de string2 em $a0
	li $v0, 4			# funcao para imprimir string
	syscall
	
end:
	li $v0, 10			# funcao para terminar o programa
	syscall
