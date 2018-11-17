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
la $t8, user_input # copy address of user input into $t8			
lb $t7,0($t8) # loads the byte value of $t8 into $t7	

#checks for empty input

beq $t7, 10, No_input_error # branches if $t7 is a new line command	
beq $t7, 0 No_input_error # branches if there is literally no input in $t7	

addi $s0, $0, 27 #initialises the register with desired base
addi $t5, $0, 0 	#initialises register for future use
addi $t4, $0, 0	 # initialises register for use
addi $t1, $0, 1 	#initializes register for future use

# processes spaces and disregards them
space_ignore:
	lb $t7,0($t8)# loads the byte value of $t8 into $t7	
	addi $t8, $t8, 1# initialises count to 1
	addi $t3, $t3, 1# initialises count to 1
	beq $t7, 32, space_ignore # if the user input is a space then we run the ignore program
	beq $t7, 10, No_input_error # if the user input is = 10(line feed) then there is no input error
	beq $t7, $0, No_input_error #if the value of the user input is null then no input error is called

#proceeds to check the individual letters to ensure that there are no intermittent spaces etc
check_characters:
	lb $t7,0($t8)# loads the byte value of $t8 into $t7	
	addi $t8, $t8, 1 # initialises count to 1
	addi $t3, $t3, 1 # initialises count to 1
	beq $t7, 10, restart_count # if the value in $t7 is empty it restarts the count
	beq $t7, 0, restart_count  #if the value in $t7 is empty it restarts the count
	bne $t7, 32, check_characters # if the user input is not equal to a space then check characters is run

check_characters_and_spaces:
	lb $t7,0($t8) # loads the byte value of $t8 into $t7
	addi $t8, $t8, 1 # initialises count to 1
	addi $t3, $t3, 1 # initialises count to 1
	beq $t7, 10, restart_count# if the value in $t7 is empty it restarts the count
	beq $t7, 0, restart_count#if the value in $t7 is empty it restarts the 
	bne $t7, 32, Out_of_range_Error ## if the user input is not equal to a space then the input is not a valid input
	j check_characters_and_spaces #jumps to function

restart_count:
	sub $t8, $t8, $t3 	#restarting the pointer in char_array
	la $t3, 0 			#restarting the counter

continue_check:
	lb $t7,0($t8) # loads the byte value of $t8 into $t7
	addi $t8, $t8, 1 # initialises count to 1
	beq $t7, 32, continue_check # if the user input is a space then we run the continue check function
	
addi $t8, $t8, -1 #initialises value to ensure proper calculations

check_length:
	lb $t7, ($t8) #loads value from t8 into t7
	addi $t8, $t8, 1 #increments
	addi $t3, $t3, 1 #increments
	beq $t7, 10, reset_pointer # if user input new line then reset pointer
	beq $t7, 0, reset_pointer #if the user input is null then reset pointer
	beq $t7, 32, reset_pointer # if the user input is a space then reset the pointer
	beq $t3, 5, Input_Long_Error # if the user input exceeds four then it is too long
	j check_length # jumps to check length function
	
reset_pointer:
	sub $t8, $t8, $t3 # subtracts the pointer from t8 and stores it in t8
	sub $t3, $t3, $t1 #subtracts t1 from t3 and stores it in t1
	lb $t7, ($t8) # loads the subracted value into t7
	sub $s1, $t3, $t1 # stores the value of t3-t1 into s1

Length_to_power:	
	beq $s1, 0, Ascii_to_decimal	#Bringing base to last power of the string
	mult $t1, $s0 #multiplies the base number by t1
	mflo $t1 #stores the value into t1
	sub $s1, $s1, 1 #decrements
	j Length_to_power

multiply:
	mult $t7, $t1 #multiples the user input by the required base
	mflo $t4			# stores the multiplication value
	add $t5, $t5, $t4 	# adds he values together to get the total
	

li $v0,10 #ends program
syscall # call operating system to perform operation

