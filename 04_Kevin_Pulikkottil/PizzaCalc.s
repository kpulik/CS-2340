.data
prompt1: .asciiz "Enter the number of round pizzas sold: "
prompt2: .asciiz "Enter the number of square pizzas sold: "
prompt3: .asciiz "Enter your estimate of total pizzas sold in square feet: "
result1: .asciiz "Total square feet of round pizzas sold: "
result2: .asciiz "Total square feet of square pizzas sold: "
result3: .asciiz "Total square feet of pizzas sold: "
woosh: .asciiz "Woosh!"
bummer: .asciiz "Bummer!"
newline: .asciiz "\n"
pi: .float 3.14159


.text
main:
# Prompt for number of round pizzas sold
li $v0, 4
la $a0, prompt1
syscall

# Read number of round pizzas sold
li $v0, 5
syscall
move $t0, $v0

# Prompt for number of square pizzas sold
li $v0, 4
la $a0, prompt2
syscall

# Read number of square pizzas sold
li $v0, 5
syscall
move $t1, $v0

# Prompt for estimate of total pizzas sold in square feet
li $v0, 4
la $a0, prompt3
syscall

# Read estimate of total pizzas sold in square feet
li $v0, 6
syscall
mov.s $f2, $f0

# Calculate total square feet of round pizzas sold (pi * r^2 * n)
# r = 5.5 inches (diameter = 11 inches)
li $t3, 11 # diameter of the pizza
li $t4, 2 # radius = diameter / 2
div $t4, $t3, $t4 # store the result of the division in $t4
mtc1 $t4, $f6 # load radius to floating point register
l.s $f4, pi
mul.s $f8, $f6, $f6 # square the radius
mul.s $f10, $f4, $f8 # multiply by pi
mtc1 $t0, $f12 # load number of round pizzas sold to floating point register
mul.s $f14, $f10, $f12 # multiply by number of pizzas sold



# Calculate total square inches of square pizzas sold (l * w * n)
# l = w = 9 inches
li $t5, 9 # length of the side of the pizza
mul $t6, $t1, $t5 # multiply number of square pizzas sold by the length of the side
mul $t7, $t1, $t5 # multiply number of square pizzas sold by the length of the side

# Convert the total square inches to square feet
mtc1 $t7, $f20 # load total square inches of square pizzas sold to floating point register
lui $at, 0x40A0 # load the upper 16 bits of the float representation of 144 (1 square foot)
ori $at, $at, 0 # load the lower 16 bits of the float representation of 144 (1 square foot)
mtc1 $at, $f22 # move the value in $at to $f22
div.s $f24, $f20, $f22 # divide by $f22

# Add the two totals to get the total square feet
add.s $f26, $f12, $f24

# Print the results
li $v0, 4
la $a0, result1 # round pizzas
syscall
li $v0, 2
mov.s $f12, $f14
syscall
li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, result2 # square pizzas
syscall
li $v0, 2
mov.s $f12, $f24
syscall
li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, result3 # all pizzas
syscall
li $v0, 2
mov.s $f12, $f26
syscall
li $v0, 4
la $a0, newline
syscall
