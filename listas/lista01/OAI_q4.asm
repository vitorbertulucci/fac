.data
.text
main:
	ori $8, $0, 4
	ori $9, $0, 5
	addi $3, $3, 3
	addi $4, $4, 5
	
loop:
	beqz $3, loop2
	addu $8, $8, $8
	addi $3, $3, -1
	j loop

loop2:
	beqz $4, end
	addu $9, $9, $9
	addi $4, $4, -1
	j loop2
	
end:
	sub $10, $8, $9
	li $v0, 10
	syscall