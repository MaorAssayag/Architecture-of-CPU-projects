	.data 
Array:      .word     200,180,190,170,160,150,130,140 # vector size is 8 numbers
	.text
main:
    addi $t0, $0, 32       # 4 bytes per int * 10 ints = 40 bytes                              
outterLoop:             # Used to determine when we are done iterating over the Array
    add $t1, $0, $0       # $t1 holds a flag to determine when the list is sorted
    add $t9, $0, $0    # Set $t9 to the base address of the Array
innerLoop:                  # The inner loop will iterate over the Array checking if a swap is needed
    lw  $t2, 0($t9)          # sets $t0 to the current element in array
    lw  $t3, 4($t9)         # sets $t1 to the next element in array
    lw  $t4, 4($t9)         # sets $t1 to the next element in array
    slt $t4, $t2, $t4       # $t5 = 1 if $t2 < $t3
    beq $t4, $0, continue   # if $t5 = 1, then swap them
    addi $t1, $0, 1             # if we need to swap, we need to check the list again
    sw  $t2, 4($t9)          # store the greater numbers contents in the higher position in array (swap)
    sw  $t3, 0($t9)         # store the lesser numbers contents in the lower position in array (swap)
continue:
    addi $t9, $t9, 4                # advance the array to start at the next location from last time
    beq  $t9, $t0, end    # If $t9 != the end of Array, jump back to innerLoop
    beq  $t1,  1,  outterLoop # $t1 = 1, another pass is needed, jump back to outterLoop
    beq  $t9, $t9, innerLoop     # If $t9 != the end of Array, jump back to innerLoop
 end :
    add $t5, $0, $0      # just fot display on ModelSim - load memory to the registes
    lw $t6, 0($t5) 
    lw $t7, 4($t5)
    lw $s0, 8($t5)
    lw $s1, 12($t5)
    lw $s2, 16($t5) 
    lw $s3, 20($t5)
    lw $s4, 24($t5)
    lw $s5, 28($t5)
