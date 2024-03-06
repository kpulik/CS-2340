.data
promptX: .asciiz "Enter X: "
promptY: .asciiz "Enter Y: "
result: .asciiz "The difference of X and Y (X - Y) is "
X: .word 0
Y: .word 0
D: .word 0

.text
.globl main
main:
  # prompt user for X and get X from the user
  li $v0, 4
  la $a0, promptX
  syscall

  li $v0, 5
  syscall

  sw $v0, X

  # prompt user for Y and get Y from the user
  li $v0, 4
  la $a0, promptY
  syscall

  li $v0, 5
  syscall

  sw $v0, Y

  # calculate X - Y
  lw $t0, X
  lw $t1, Y
  sub $t2, $t0, $t1
  sw $t2, D

  # print result
  li $v0, 4
  la $a0, result
  syscall

  lw $a0, D
  li $v0, 1
  syscall

  # exit
  li $v0, 10
  syscall
