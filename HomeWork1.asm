  .data                        

 

       user_input: .space 9         #Allocates 9 bytes of storage for 8 characters

       invalid_input:               #String to display if invalid

              .asciiz "\n Invalid hexadecimal number \n"

 

 

       .text                         #Beginning of Text segment

 

main:

       addi, $s3, $0, 0

      

       li $v0, 8                   #call code to read string

       la $t0, user_input        #load address of user_input in register $t0

       la $a0, ($t0)             #load address of user_input in $t0 to argument register $a0

       la $a1, 9                 #gets length of space in myWord to avoid exceeding memory limit

       syscall                      #syscall to read user_input and store the string in memory

      

       addi $t7, $t0, 8            #add the value of the 9th byte of user_input to the register $t7

       addi $s5, $t0, 0

checklength:

       lb $t1, 0($s5)

       beq $t1, 0, subtractfour

       beq $t1, 10, subtractfour

       addi $s3, $s3, 4

       addi $s5, $s5, 1

       j checklength

subtractfour:

       addi $s3, $s3, -4			#Remove extra 4

iterate_string:                     #iterate through input to check if all the charectars are valid    

      

       lb $t1, 0($t0)                #first byte of memory into register $t1

       beq $t1, 0, less_than_ten

       beq $t1, 10, less_than_ten

       blt $t1, 48, invalid         #branch to invalid label if value in $t1 is less than 48 (ASCII dec for number 0)       

       addi $s1, $0, 48

       blt $t1, 58, valid           #branch to invalid label if value in $t1 is less than 58 (next ASCII dec for number 9)            

       blt $t1, 65, invalid         # 65 = Decimal for 'A'

       addi $s1, $0, 55

       blt $t1, 71, valid           # 71 = Decimal for 'G' , valid up to 'F'

       blt $t1, 97, invalid         # 97 = Decimal for 'a'

       addi $s1, $0, 87

       blt $t1, 103, valid  

       bgt $t1, 102, invalid     #branch to invalid if value in $t1 is greater than 102 (ASCII dec for 'f')

      

invalid:                      #label to call invalid and exit program

       li $v0, 4

       la $a0, invalid_input

       syscall

       li $v0, 10                 #exit

       syscall

valid:                          #label to call valid and exit program

       addi $t0, $t0, 1            #increment offset of $t0 by 1

       sub $s4, $t1, $s1

       sllv $s4, $s4, $s3

       addi $s3, $s3, -4

       add $s2, $s4, $s2

       bne $t0, $t7, iterate_string    #if offset of $t0 is not equal to $t7, branch to iterate_string to continue looping

 

less_than_ten:

       addi $s0, $0, 10

       addi $t0, $t0, -1

       lb $t1, 0($t0)					#Checking if the first value is less that 8 because if it's greater then the output will be faulty

       blt $t1, 58, exit_loop

       divu $s2, $s0

       mflo $a0

       li $v0, 1

       syscall

       mfhi $s2

      

exit_loop:

       li $v0, 1

       addi $a0, $s2, 0

       syscall

       li $v0, 10                 #call code to exit program

       syscall