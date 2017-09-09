.data
bytes:	.word	0xFFFFFFFF
.text
main:
	ori $1, $0, 0x01	# set $1 to 1
	lw $a0, bytes		# load byte address to $a0 argument
	j loop			# call loop function
	
loop:
	addi $1, $1, 15		# add imediate 15 to register $1 less significant byte
	beq $1, $a0, end	# check if $1 is equal than our bytes
	sll $1, $1, 4		# shift the resiter $1 1 byte to left
	j loop			# loop again
	
end:
	li $v0, 10		# load end function
	syscall			# end it