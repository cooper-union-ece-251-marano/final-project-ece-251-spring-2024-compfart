addi $a0 $zero 7 # INPUT: 5 (can only add up to 7 at once)
addi $a0 $a0 2
addi $sp $zero -2
jal 0xA
sw $v0 0($zero)
addi $sp $sp -6
sw $ra 0($sp)
sw $s0 2($sp)
sw $s1 4($sp)
move $s0 $a0
addi $v0 $zero 1
addi $t0 $zero 2
slt $at $t0 $s0
beq $at $zero 0xC
addi $a0 $s0 -1
jal 0xA
move $s1 $v0
addi $a0 $s0 -2
jal 0xA
add $v0 $s1 $v0
lw $s1 4($sp)
lw $s0 2($sp)
lw $ra 0($sp)
addi $sp $sp 6
jr $ra