# We place some data in the array to work with
    .data
Array: .word 1, 2, 3, 4, 5
    .globl    main
    .text
main:

    # initialize the inputs
    la    $s1, Array    #load address of the Array in $s0
    li    $s2, 5        #load inm. 5 in k ($s2)
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

Exit:     li $s1, 1         #load 1 in $s1 just to show the operation is complete
