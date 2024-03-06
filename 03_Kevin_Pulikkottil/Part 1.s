# Data segment
.data
array: .space 800   # Create an array with 200 words initialized to 0
input_prompt: .asciiz "Enter an integer between 0 and 100: "
error_msg: .asciiz "Invalid input. Please enter a number between 0 and 100.\n"
output_msg: .asciiz "The double sum of integers from 0 to %d is: %d\n"

# Text segment
.text
.globl main

main:
    # Ask user for input
    li $v0, 4           # Load print string into register $v0
    la $a0, input_prompt    # Load the address of input prompt string into $a0
    syscall

    # Read integer input from user
    li $v0, 5           # Load read integer into register $v0
    syscall
    move $t0, $v0       # Move input value from register $v0 to $t0

    # Check if input is valid
    bgt $t0, 100, invalid_input # Branch if input is greater than 100
    blt $t0, 0, invalid_input  # Branch if input is less than 0
    beq $t0, 0, exit_program   # Branch if input is 0

    # Fill array with values from 0 to 2*N
    li $t1, 0           # Initialize loop counter to 0
    li $t2, 0           # Initialize array index to 0
    fill_array_loop:
        bgt $t1, $t0, end_fill_array # Branch if loop counter exceeds input value
        sll $t3, $t1, 1     # Multiply loop counter by 2
        sw $t3, array($t2)  # Store result in array
        addi $t1, $t1, 1    # Increment loop counter
        addi $t2, $t2, 4    # Increment array index
        j fill_array_loop   # Repeat loop

    # Calculate sum of array elements
    li $t4, 0           # Initialize sum to 0
    li $t2, 0           # Reset array index to 0
    sum_loop:
        bge $t2, $t0, end_sum # Branch if array index exceeds input value
        lw $t3, array($t2)  # Load element from array into $t3
        add $t4, $t4, $t3   # Add element to sum
        addi $t2, $t2, 4    # Increment array index
        j sum_loop          # Repeat loop

    # Print sum of array elements
    li $v0, 1           # Load print integer into register $v0
    move $a0, $t0       # Move input value to $a0
    mul $t4, $t4, 2     # Double sum of array elements
    move $a1, $t4       # Move doubled sum to $a1
    la $a2, output_msg  # Load address of` output message into $a2
    syscall

    j main              # Restart program

invalid_input:
    # Print an error message and restart program
    li $v0, 10