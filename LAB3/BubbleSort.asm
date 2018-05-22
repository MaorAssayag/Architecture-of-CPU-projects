	.data 
Array:      .word    0x42fee979 , 6,7,5,4,3,2,1 # vector size is 8 numbers, should be replaced with floatingpoint represntion

	.text
main:
    la  $t0, Array      # Copy the base address of your array into $t0
    add $t0, $t0, 40    # 4 bytes per int * 10 ints = 40 bytes                              
outterLoop:             # Used to determine when we are done iterating over the Array
    add $t1, $0, $0     # $t1 holds a flag to determine when the list is sorted
    la  $a0, Array      # Set $a0 to the base address of the Array
innerLoop:                  # The inner loop will iterate over the Array checking if a swap is needed
    lw  $t2, 0($a0)         # sets $t0 to the current element in array
    lw  $t3, 4($a0)         # sets $t1 to the next element in array
    slt $t5, $t2, $t3       # $t5 = 1 if $t0 < $t1
    beq $t5, $0, continue   # if $t5 = 1, then swap them
    add $t1, $0, 1          # if we need to swap, we need to check the list again
    sw  $t2, 4($a0)         # store the greater numbers contents in the higher position in array (swap)
    sw  $t3, 0($a0)         # store the lesser numbers contents in the lower position in array (swap)
continue:
    addi $a0, $a0, 4            # advance the array to start at the next location from last time
    bne  $a0, $t0, innerLoop    # If $a0 != the end of Array, jump back to innerLoop
    bne  $t1, $0, outterLoop    # $t1 = 1, another pass is needed, jump back to outterLoop
