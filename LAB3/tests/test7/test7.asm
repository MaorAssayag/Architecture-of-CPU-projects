#This program implements the following C code
#if (i<j)
#	f=g+h;
#else
#	f=g-h;
#end
.data 
i: .word 120
j : .word 140
.text
# Before running this code make sure that
# Settings -> Memory Configuration -> Compact, Data at Address 0
	lw $t1,0   #$t1=i
	lw $t2,4   #$t1=i
        add $t2,$t1,$t1 
         add $t2, $t2, $t2