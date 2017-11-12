.data
	mystring:	.asciiz "This is the 8 or less character text: "
	userInput:	.space 8
.text
	main:
		# Getting user's input as text
		li $v0, 8
		la $a0, userInput
		li $a1, 8
		syscall
		
		# Displays Hello String
		li $v0, 4
		la $a0, mystring
		syscall
		
		# Displays the name
		li $v0, 4
		la $a0, userInput
		syscall
		
	# Tell the system this is the end of the main.
	li $v0, 10
	syscall