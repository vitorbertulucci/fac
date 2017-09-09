	.data
	.text
readInteger:
	li $v0, 5	# load the read integer function to $v0
	syscall		# execute the SO function to scanner
	la $t0, ($v0)	# load value from scanner and set to temporary $t0

printValue:
	la $a0, ($t0)	# load address from $t0 (result of read function) to argument 0
	li $v0, 1	# load the print integer function to $v0
	syscall		# execute SO function to print
	
return0:
	li $v0, 10	# load endFunction to $v0
	syscall		# execute SO function to end the program