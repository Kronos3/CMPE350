####################
#    Question 1    #
####################

# We place some data in the array to work with
    .data
Array: .word 1, 2, 3, 4, 5
    .globl    main
    .text
main:
    # RUN Question 1
    j q1_main

    # RUN question 2
    # j q2_main

    # If nothing is run
    # Exit with no action
    j Exit

q1_main:
    # initialize the inputs
    la    $s1, Array    #load address of the Array in $s1
    li    $s2, 5        # size of array in $s2
    li    $s3, 0        # the index initialized to 0 is in $s3
    li    $s0, 0        # sum = 0

AddWhile:
    bge $s3, $s2, Exit  # while (i < n)
    sll $t0, $s3, 2     # offset = 4 * i
    add $t0, $t0, $s1   # offset_addr = &Array[i]
    lw $t0, 0($t0)      # t0 = Array[i]
    add $s0, $s0, $t0   # s0 += t0
    addi $s3, $s3, 1    # i++
    j AddWhile

Exit:
    # exit()
    li      $v0, 10     # terminate program run and
    syscall             # Exit


####################
#    Question 2a   #
####################

    sll $t1,$a1,2     # Create an address offset given index k
    add $t1,$a0,$t1   # Get the offset address of memory v
    lw $t0,0($t1)     # Get data at v[k]
    lw $t2,4($t1)     # Get data at v[k+1]
    sw $t2,0($t1)     # These two instructions will swap the values
    sw $t0,4($t1)     # of v[k] and v[k+1]

####################
#    Question 2b   #
####################
swap_idx:
    # addi $sp,$sp,-12
    # We don't need 12 bytes from the stack
    addi $sp,$sp,-8

    # Save the values of t0 and t1
    sw $t0, 4($sp)
    sw $t1, 0($sp)

    # Get value &v[k]
    sll $t1, $a1, 2
    add $t1, $a0, $t1

    # Swap v[k] and v[k+1]
    lw $t0, 0($t1)
    lw $t2, 4($t1)
    sw $t2, 0($t1)
    sw $t0, 4($t1)

    # We need to restore the values of t0 and t1
    # The old values are stored on the stack
    lw $t0, 4($sp)
    lw $t1, 0($sp)

    # Restore the stack
    addi $sp,$sp,8
    jr $ra

####################
#    Question 2c   #
####################
q2_main:
    # Call swap_idx to move the first index to the end
    # Do this by continually swapping indecies to n-1

    # Initialize the input data
    la    $s0, Array    # load array address in s0
    li    $s1, 5        # load size of array in s1

    # Data to pass to swap_idx:
    #  - a0: base address of array
    #  - a1: k (swap k and k+1)

    # a0 stays constant so we can simply load the base address
    addi  $a0, $s0, 0

    li  $a1, 0  # k = 0
    addi $s2, $s1, -1    # max_k = size - 1

q2c_while:
    # In general $argument registers are not saved
    # by the MIPS calling convention. In this case they
    # are though so we can use a1 as a counter.
    bge $a1, $s2, Exit   # while (k < n - 1)  // n is the size of the array

    jal swap_idx         # swap k and k + 1
    addi $a1, $a1, 1     # k++
    j q2c_while
