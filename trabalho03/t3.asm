.data
	digit:		.float	0.0			# numero a ser calculado o arcsenonumero
	LIMIT: 		.float 	1.0			# valor maximo do mnumero
	string_error:	.asciiz "\nValor fora do limite permitido!\n"
	str1: 		.asciiz "\nO arcseno de "
	str2: 		.asciiz " eh "
	str3: 		.asciiz ". Usamos "
	str4: 		.asciiz " termos da serie.\n"
	PRECISAO: 	.float 	0.01			# precisao para o crit�rio de parada de convergencia
	INICIO_SERIE: 	.word   0			# n = 0
	resultado: 	.float  0.0			# armazena o resultado da soma dos termos da serie
	quebra_linha: 	.asciiz	 "\n"
	string: .asciiz "O termo da série eh: "
.text
main:
	lwc1 $f31, PRECISAO			# carrega o valor de precisao e armazena em $f31 do Coproc 1
	lwc1 $f30, resultado
	lw $s0, INICIO_SERIE			# s0 = n
	jal le_float
	lwc1 $f29, digit			# armazena o valor do numero em $f29
	jal validar_limites
	j calc_arcsen

le_float: # ok
	li $v0, 6				# carrega read_float em v0
	syscall					# executa a funcao
	swc1 $f0, digit				# armazena o resultado em digit
	jr $ra

validar_limites: # ok
	lwc1 $f1, LIMIT				# carrega o valor de LIMIT
	abs.s $f0, $f29				# converte o valor de digit para absoluto e armazena no proprio $f0
	c.le.s $f0, $f1				# seta o CF 0 para true (um) se o $f0 for menor que $f1
	bc1f fora_do_limite 			# se o CF 0 eh falso, o valor esta fora do limite de o jump para 'fora_do_limite'
	jr $ra					# retorna para onde o chamou
	
calc_arcsen:
	jal calcula_dividendo			# calcula o dividendo e armazena o resultado em $f14 -------> OK
	mov.s $f12, $f14
	li $v0, 2
	syscall
	la $a0, quebra_linha
	li $v0, 4
	syscall
	jal calcula_divisor			# calcula o divisor e armazena em $f24 -----> ok
	mov.s $f12, $f24
	li $v0, 2
	syscall
	la $a0, quebra_linha
	li $v0, 4
	syscall
	div.s $f6, $f14, $f24 	 		# calcula o termo da serie
	mov.s $f12, $f6
	li $v0, 2
	syscall
	la $a0, quebra_linha
	li $v0, 4
	syscall
	add.s $f30, $f30, $f6			# soma o novo termo ao resultado ate entao da serie
	la $a0, string
	li $v0, 4
	syscall
	mov.s $f12, $f30
	li $v0, 2
	syscall	
	la $a0, quebra_linha
	li $v0, 4
	syscall
	c.le.s $f6, $f31	   		# verfica o termo eh menor ou igual a precisao
	bc1t imprime_saida
	addi $s0, $s0, 1			# incrementa o n
	j calc_arcsen
	
calcula_dividendo: # (2n)!.x^(2n +1) ---> OK
	move $t4, $ra				# salva o endere�o de ra em t4, para nao perder o endereco de retorno
	mov.s $f10, $f29			# inicia o valor de x^(2n + 1) com o pr�prio x
	jal calcula_2n				# calcula 2n. Resultado em $s7
	move $t0, $s7				# coloca o valor do 2n em $t0 para calcular (2n)!
	jal recebe_numero_para_fatorial		# computa o fatorial de 2n ($t0), com o resultado em $f16
	addi $s6, $s7, 1			# $s6 = 2n + 1
	jal calcula_potencia_para_x		# calcula x^(2n + 1) e armazena o valor em $f10
	mul.s $f14, $f10, $f16			# resultado de (2n)!.x^(2n +1)
	move $ra, $t4				# restaura o retorno para $ra
	jr $ra					# retorna para onde o chamou
	
calcula_divisor: # (2^(2n)).((n!)^(2)).(2n + 1) -----> OK
	move $t4, $ra				# salva o endere�o de ra em t4, para nao perder o endereco de retorno
	addi $t8, $zero, 2			# armazena o valor 2 em $t8
	jal calcula_2n				# calcula 2n. Resultado em $s7
	jal calcula_potencia_de_2n		# calcula 2^(2n) e armazena o valor em $t8
	move $t0, $s0				# $t0 = n, para calcular o fatorial
	jal recebe_numero_para_fatorial		# passa o valor de $t0 para calcular n!, deixando o resultado em $f16
	mtc1 $t8, $f8
	cvt.s.w $f8, $f8			# converte f8 para float
	mul.s $f16, $f16, $f16			# (n!)^2
	mul.s $f8, $f8, $f16			# f5 = (2^(2n)).((n!)^(2))
	jal calcula_2n				# calcula 2n
	addi $s7, $s7, 1			# 2n + 1
	mtc1 $s7, $f22				# armazena o (2n + 1) para o CP1
	cvt.s.w $f22, $f22			# converte para float o valor de (2n + 1)
	mul.s $f24, $f22, $f8			# f24 = (2^(2n)).((n!)^(2)).(2n + 1), calculando o resultado do termo do divisor
	move $ra, $t4				# restaura o retorno para $ra
	jr $ra					# retorna para onde o chamou

calcula_potencia_de_2n: # 2^(2n) -----> OK
	beq $s7, 0, retorna_1			# se n == 0, retorna o valor 1
	beq $s7, 1, return			# se n == 1, retorna
	addi $t9, $zero, 2			# t9 = 2
	mult $t8, $t9				# t8 x 2
	mflo $t8				# armazena o resultado da multiplicacao em t8
	sub $s7, $s7, 1				# diminui um da potencia
	j calcula_potencia_de_2n

retorna_1:
	addi $t8, $zero, 1
	jr $ra

calcula_2n:
	add $s7, $s0, $s0			# $s7 = 2n
	jr $ra

calcula_potencia_para_x:
	beq $s6, 1, return
	mul.s $f10, $f10, $f29			# $f10 = $f10.x
	subi $s6, $s6, 1			# (2n + 1) - 1
	j calcula_potencia_para_x

return:
	jr $ra

recebe_numero_para_fatorial:
	move $t3, $ra				# armazena o endereço de retorno da função
	mtc1 $t0, $f16				# coloco o valor do fatorial a ser calculado no registrador co CP1
	cvt.s.w $f16, $f16			# inicia o termo do fatorial como sendo o prórprio n
	jal fatorial				# chama a funcao fatorial e armazena o valor em $f15
	move $ra, $t3				# restaura o valor de retorno (poderia utilizar pilha)
	j return				# retorna

fatorial:
	beq $t0, 0, return1			# se n = 1, retorna, pois o valor é o próprio n
	subi $t0, $t0, 1			# decrementa o n
	mtc1 $t0, $f18				# coloco o valor do fatorial a ser calculado no registrador co CP1
	cvt.s.w $f18, $f18			# inicia o termo do fatorial como sendo o prórprio n
	mul.s $f16, $f16, $f18			# f15 = f15.(n-1)
	beq $t0, 1, return			# se n = 0, retorna 1, pois 0! = 1
	j fatorial
	
return1:
   	lwc1 $f16, LIMIT				# se n = 0, retorna 1.0 como resultado do fatorial
    	j return	

imprime_saida:
	la $a0, str1
	li $v0, 4
	syscall
	mov.s $f12, $f29
	li $v0, 2
	syscall
	la $a0, str2
	li $v0, 4
	syscall
	mov.s $f12, $f30
	li $v0, 2
	syscall
	la $a0, str3
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall
	la $a0, str4
	li $v0, 4
	syscall
	j end
	
fora_do_limite:	# ok
	la $a0, string_error
	li $v0, 4
	syscall
	j end
	
end: # ok
	li $v0, 10
	syscall
