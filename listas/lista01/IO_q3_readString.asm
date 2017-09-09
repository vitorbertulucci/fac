	.data
string: .space 	80	# 80 bytes string
space:	.byte 	' '	# constant space
tam:	.word 	80	# as max of array
	.text
main:
	la $a0, string		# load string address to $a0
	lb $a1, tam		# load tam byte to $a1
	li $v0, 8		# call scanner  function
	syscall			# order SO to execute it
	li $t0, 0		# set $t0 to 0
	j findWhiteSpaces	# call loop function
	
findWhiteSpaces:
	lb $t1, 0($a0)		# load the first character of string
	lb $t2, space		# load space to $t2
	beq $t1, $t2, addSpace	# if t1 == t2 -> addSpace
	beqz $t1, printResult	# if t1 == EOS -> printResult
	addi $a0, $a0, 1	# shift string to left
	j findWhiteSpaces	# loop again
	
addSpace:
	addi $t0, $t0, 1	# add 1 to counter
	addi $a0, $a0, 1	# shift string to left
	j findWhiteSpaces	# loop again

printResult:
	la $a0, ($t0)		# load content of $t0 and set to $a0
	li $v0, 1		# call print function
	syscall			# order to SO to print the result
end:
	
	li $v0, 10		# call exit function
	syscall			# order to SO to execute it	
