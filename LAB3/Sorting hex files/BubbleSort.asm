	.data 
Array:      .word     130,140,110,120 # vector size is 8 numbers, should be replaced with floatingpoint represntion
	.text
main:
    add $t0, $0, 16       # 4 bytes per int * 10 ints = 40 bytes                              
outterLoop:             # Used to determine when we are done iterating over the Array
    add $t1, $0, $0      # $t1 holds a flag to determine when the list is sorted
    add $t9, $0, $0    # Set $t9 to the base address of the Array
innerLoop:                  # The inner loop will iterate over the Array checking if a swap is needed
    lw  $t2, 0($t9)         # sets $t0 to the current element in array
    lw  $t3, 4($t9)         # sets $t1 to the next element in array
    slt $t5, $t2, $t3       # $t5 = 1 if $t2 < $t3
    beq $t5, $0, continue   # if $t5 = 1, then swap them
    add $t1, $0, 1          # if we need to swap, we need to check the list again
    sw  $t2, 4($t9)         # store the greater numbers contents in the higher position in array (swap)
    sw  $t3, 0($t9)         # store the lesser numbers contents in the lower position in array (swap)
continue:
    addi $t9, $t9, 4            # advance the array to start at the next location from last time
    bne  $t9, $t0, innerLoop    # If $t9 != the end of Array, jump back to innerLoop
    bne  $t1, $0, outterLoop    # $t1 = 1, another pass is needed, jump back to outterLoop
 end :
    add $t8, $0, $0      # just fot checking
    lw $t6, 0($t8)
    lw $t7, 4($t8)
    lw $t8, 8($t8)
    lw $t9, 12($t8)

