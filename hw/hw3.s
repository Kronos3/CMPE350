# We place some data in the array to work with
	.data
Array: .word 5, 5, 5, 5, 5, 2, 0, 0

	.globl	main

	.text
main:

	# initialize
	la	$s0, Array	#load address of the Array in $s0
	li	$s2, 5		#load inm. 5 in k ($s2)
	li	$s3, 0		# the index initialized to 0 is in $s3

While:	sll $t1, $s3, 2		#$t1<-$s3<<	multiply $s3 times 4 to get the offset in number of Bytes from the base of the array
	add $t1, $s0, $t1	#$t1<-$t1+$s0	Calculate the address of the array's element by adding offset+base of array
	lw $t1, 0($t1)		#$t1<-M($t1+0)	load elment in $t1
	bne $t1, $s2, Exit	#$t1=/$s2:PC<-Exit	exit if the element is not equal to k
	addi $s3, $s3, 1	#$s3<-$s3+1	increment index by one.
	j While 		#PC<-While	loop back to While

Exit: 	li $s1, 1 		#load 1 in $s1 just to show the operation is complete
