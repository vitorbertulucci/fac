	.data
hello: .asciiz "Alô mundo!" 	# declara a string para a 'variável' hello.

	.text
print: 	
	la $a0, hello 		# carregue o endereço de hello e joque para o argumento $a0
	li $v0, 1 		# especifica o mecanismo/serviço de Print String
	syscall			# print o hello
