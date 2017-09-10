.data
.text
main:
	ori $8, $0, 5
	add $t7, $0, $8
	addi $t8, $0, 12
	j loop
	
loop:
	beqz $t8, end
	addu $8, $8, $t7
	addi $t8, $t8, -1
	j loop
	
end:
	li $v0, 10
	syscall