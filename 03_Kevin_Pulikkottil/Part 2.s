.data
prompt: .asciiz "Give me a number between 1 and 10 (0 to stop): "
lead: .asciiz "The countdown of integers from "
iterative: .asciiz "ITERATIVE: "
recursive: .asciiz "RECURSIVE: "

.text
.globl main

itr_countdown:
    addi $sp, $sp, -4       # allocating space for return address
    sw $ra, 0($sp)          # saving return address
    li $t0, 0               # initialize the loop counter
    add $t1, $a0, $zero     # copy the argument to $t1
    la $a0, iterative       # load iterative string
    li $v0, 4               # print string
    syscall
itr_countdown_loop:
    bgez $t1, itr_countdown_print # if $t1 is >= 0, go to print
    j itr_countdown_exit    # jump to exit if $t1 is negative
itr_countdown_print:
    move $a0, $t1           # move $t1 to $a0 to printing
    li $v0, 1               # print integer
    syscall
    li $v0, 4               # print space
    la $a0, " "
    syscall
    addi $t1, $t1, -1       # decrement loop counter
    j itr_countdown_loop    # jump to loop
itr_countdown_exit:
    li $v0, 4               # print newline
    la $a0, "\n"
    syscall
    lw $ra, 0($sp)          # restore the return address
    addi $sp, $sp, 4        # deallocate stack space
    jr $ra                  # return

# rec_countdown procedure
rec_countdown:
    addi $sp, $sp, -4       # allocate space for return address
    sw $ra, 0($sp)          # save return address
    la $a0, recursive       # load recursive string
    li $v0, 4               # print string
    syscall
    add $t0, $a0, $zero     # copy argument to $t0
    bgez $a0, rec_countdown_start
 
 # if $a0 is >= 0, start recursion
    j rec_countdown_exit    # jump to exit if $a0 is negative

rec_countdown_start:
    addi $sp, $sp, -4       # allocate space for $t0
    sw $t0, 0($sp)          # save $t0
    addi $a0, $a0, -1       # decrement argument
    jal rec_countdown       # recursive call
    lw $t0, 0($sp)          # restore $t0
    addi $sp, $sp, 4        # deallocate stack space
    move $a0, $t0           # move $t0 to $a0 for printing
    li $v0, 1               # print integer
    syscall
    li $v0, 4               # print space
    la $a0, " "
    syscall
    beqz $t0, rec_countdown_exit    # if $t0 is zero, jump to exit
    addi $t0, $t0, -1               # decrement $
 rec_countdown_print:
  jal rec_countdown                 # recursive call
 rec_countdown_exit:
  li $v0, 4                         # print newline
  la $a0, "\n"
  syscall
  lw $ra, 0($sp)                    # restore return address
  addi $sp, $sp, 4                  # deallocate stack space
  jr $ra                            # return

#main program
main:
  li $t0, 1                 # initialize loop counter
  main_loop:
    li $v0, 4                 # print prompt
    la $a0, prompt
    syscall
    li $v0, 5                 # read integer
    syscall
    beqz $v0, main_exit       # if the input is zero, exit program
    add $a0, $v0, $zero       # copy input to $a0
    li $v0, 4                 # print leading string
    la $a0, lead
    syscall
    move $a1, $v0             # move value of $v0 to $a1
    jal itr_countdown         # call itr_countdown
    move $a1, $v0             # move value of $v0 to $a1
    jal rec_countdown         # call rec_countdown
    j main_loop               # repeat loop
main_exit:
  li $v0, 10                # exit program
  syscall