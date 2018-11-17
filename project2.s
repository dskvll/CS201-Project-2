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

li $v0,10 #ends program
syscall # call operating system to perform operation

