#This program implements the following C code
#if (i<j)
#	f=g+h;
#else
#	f=g-h;
#end
.data 
i: .word 1 
j: .word 2
g: .word 3
.text
# Before running this code make sure that
# Settings -> Memory Configuration -> Compact, Data at Address 0
	lw $t1,0#$t1=i
	lw $t2,4#$t2=j
	lw $t3,8#$t3=g
        add $t4,$t1,$t2 
	add $t4,$t4,$t3 
	move $t5,$t4