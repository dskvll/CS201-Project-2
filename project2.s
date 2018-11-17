#mips Project 2 base converter
.data # Data declaration section
too_long_input: .asciiz "Input is too long."
out_of_range: .asciiz "Invalid base-27 number." 
empty_input: .asciiz "Input is empty."
user_input: .space 50000
.text # Assembly language instructions
main: # Start of code section

# begins getting user input

li $v0, 8   # read string command
la $a0, user_input #stores user string into register
li $a1, 50000 
syscall # calls previous instructions

add $t7, $0, 0 #initialises register
add $t7, $0, 0 #initialises register
la $t0, user_input # copy address of user input into $t0			
lb $t7,0($t0) # loads the byte value of $t0 into $t7	

#checks for empty input

beq $t7, 10, No_input_error # branches if $t7 is a new line command	
beq $t7, 0 No_input_error # branches if there is literally no input in $t7	

addi $s0, $0, 27 #initialises the register with desired base
addi $t6, $0, 0 	#initialises register for future use
addi $t5, $0, 0	 # initialises register for use
addi $t1, $0, 1 	#initializes register for future use

space_ignore:
	lb $t7,0($t0)# loads the byte value of $t0 into $t7	
	addi $t0, $t0, 1# initialises count to 1
	addi $t3, $t3, 1# initialises count to 1
	beq $t7, 32, space_ignore # if the user input is a space then we run the ignore program

li $v0,10 #ends program
syscall # call operating system to perform operation

