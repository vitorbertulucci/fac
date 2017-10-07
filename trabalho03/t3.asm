.data
	digit:	.float	0	# numero a ser calculado o arcsenonumero
	LIMIT: 	.float 	1	# valor maximo do mnumero
	string_error: .asciiz 	"Valor fora do limite permitido!"
.text
main:
	jal le_float
	jal validar_limites
	jal calc_arcsen
	j end

le_float: # ok
	li $v0, 6		# carrega read_float em v0
	syscall			# executa a funcao
	s.s $f0, digit		# armazena o resultado em digit
	l.s $f12, digit		# carrega o valor de digit em f12 ---- modificar para algo mais rapido  (leitura da memoria é mais lento)
	li $v0, 2
	syscall
	jr $ra


validar_limites: # ok
	l.s $f0, digit		# carrega o digit para $f0
	abs.s $f0, $f0		# converte o valor de digit para absoluto e armazena no proprio $f0
	l.s $f1, LIMIT		# carrega o valor de LIMIT
	c.le.s $f0, $f1		# seta o CF 0 para true (um) se o $f0 for menor que $f1
	bc1f fora_do_limite	# se o CF 0 eh falso, o valor esta fora do limite de o jump para 'fora_do_limite'
	jr $ra			# retorna para onde o chamou
	
calc_arcsen:
	# implementar funcao
	jr $ra
	
imprime_saida:
	# implementar funcao
	jr $ra
	
fora_do_limite:	# ok
	la $a0, string_error
	li $v0, 4
	syscall
	j end
	
end: # ok
	li $v0, 10
	syscall
