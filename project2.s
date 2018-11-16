#mips Project 2 base converter
.data # Data declaration section
too_long_input: .asciiz "Input is too long."
out_of_range: .asciiz "Invalid base-27 number." 
empty_input: .asciiz "Input is empty."
user_input: .space 50000
.text # Assembly language instructions
main: # Start of code section

syscall # call operating system to perform operation

