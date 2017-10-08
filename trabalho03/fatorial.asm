.text 
main:
	li $a0, 3
	jal Soma_recursiva
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
Soma_recursiva :
	addi $sp , $sp , -8 # prepara a pilha para receber 2 itens
	sw $ra , 4( $sp ) # empilha $ra ( End . Retorno )
	sw $a0 , 0( $sp ) # empilha $a0 ( n )
	slti $t0 , $a0 , 1 # testa se n < 1
	beq $t0 , $zero , L1 # se n >=1 , v´a para L1
	add $v0 , $zero , $zero # valor de retorno ´e 0
	addi $sp , $sp , 8 # remove 2 itens da pilha
	jr $ra # retorne para depois de jal
L1 :
	addi $a0 , $a0 , -1 # argumento passa a ser (n -1)
	jal Soma_recursiva # calcula a soma para (n -1)
	lw $a0 , 0( $sp ) # restaura o valor de n
	lw $ra , 4( $sp ) # restaura o endere¸co de retorno
	addi $sp , $sp , 8 # retira 2 itens da pilha .
	add $v0 , $a0 , $v0 # retorne n + soma_recursiva (n -1)
	jr $ra # retorne para a chamadora
