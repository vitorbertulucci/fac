.data
.text
main:
	ori $8, $0, 0
	addi $t1, $0, 16
	

loop:
	beq $t1, $0, continue
	addi $8, $8, 0x1000
	addi $t1, $t1, -1
	j loop
	
continue:
	ori $9, $0, 0x1000
	sll $9, $9, 4
	ori $10, $0, 0x1000
	addi $t3, $0, 15
	
loop2:
	beq $t3, $0, end
	addi $10, $10, 0x1000
	addi $t3, $t3, -1
	j loop2
	
end:
	li $v0, 10
	syscall