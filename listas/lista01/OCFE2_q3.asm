.data
	minor_range:	.word	20, 40
	max_range:	.word	60, 80
	temp:		.word	59
.text
main:
	la $a0, minor_range	# carrega o intervalo menor
	la $a1, max_range	# carrega o intervalo maior
	lw $t0, 0($a0)		# carrega o primeiro limite inferior
	lw $t1, 4($a0)		# carrega o primeiro limite superior
	lw $t2, 0($a1)		# carrega o segundo limite inferior
	lw $t3, 4($a1)		# carrega o segundo limite superior
	lw $t4, temp		# carrega a temperatura
	j checkFirstInterval	# chama o check

setTo1:
	ori $v1, $0, 1	# adiciona 1 no registrador
	li $v0, 10	# chama o finalizador
	syscall		# finaliza

checkFirstInterval:
	bge $t4, $t0, checkSecondInterval	# verifica se está dentro do prim. limite inferior
	j end					# se não for, chama a end

checkSecondInterval:
	ble $t4, $t1, setTo1			# se está entre ou igual o primeiro limite superior, chama a setTo1
	
checkThirdInterval:
	bge $t4, $t2, checkFourthInterval	# verifica se está dentro do seg. limite inferior
	j end					# se não for, chama a end
checkFourthInterval:
	ble $t4, $t3, setTo1			# se está entre ou igual o segundo limite superior, chama a setTo1
	
end:
	ori $v1, $v1, 0	# coloca o v1 para 0, mostrando que está fora do limite
	li $v0, 10	# chama a finalizadora
	syscall		# finaliza

