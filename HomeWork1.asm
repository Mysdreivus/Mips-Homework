.data
	
	#Allocates space for 8 characters
	
	userInput:	.space 9
	invalid_info: .asciiz "\n Invalid Hexadecimal Number \n"
.text
	main:
	
		# Getting input
		li $v0, 8
		la $a0, userInput
		li $a1, 8
		syscall
	
	loop_string:
		
		#looping over the string checking each value
		
		lb  $t2, 0($t0)	#load first byte of memory into register $t2
		beq $t2, 0,  exit
		beq $t2, 10, exit
		
		blt $t2, 48, invalid		#branch to invalid label
		addi $s1, $0, 48
		blt $t2, 58, valid
		blt $t2, 65, invalid
		addi $s1, $0, 55
		blt  $t2, 71, valid
		blt $t2, 97, invalid
		addi $s1, $0, 87
		blt $t2, 103, valid
		bgt $t2, 102, invalid
		addi $s3, $s3, 4
	
	invalid: 			
		li $v0, 4
		la $a0, invalid_info
		syscall
		li $v0, 10
		syscall
	
	valid:
		addi $t0, $t0, 1
		sub $s4, $t1, $s1
		sllv $s4, $s4, $s3
		add $s2, $s4, $s2
		bne $t0, $t7, loop_string
		
	exit:
		li $v0, 1
		addi $a0, $s2, 0			#This exits the program
		syscall
		li $v0, 10
		syscall
	

	
	# Tell the system this is the end of the main.
	li $v0, 10
	syscall
