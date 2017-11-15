.data
	mystring:	.asciiz "Enter the 8 character code: "
	
	# Allocates space for 8 characters
	
	userInput:	.space 8
	finalstring:	.asciiz "The string is: "
.text
	main:
		# Displays Hello String
		li $v0, 4
		la $a0, mystring
		syscall
		
		# Getting user's input as text
		li $v0, 8
		la $a0, userInput
		li $a1, 8
		syscall
		
		# Displays the final string
		li $v0, 4
		la $a0, finalstring
		syscall
		
		# Displays the name
		li $v0, 4
		la $a0, userInput
		syscall
		
	# Tell the system this is the end of the main.
	li $v0, 10
	syscall
