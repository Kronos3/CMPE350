# N-Factorial program
#
# Author: Andrei Tumbar
# Author: Justin Shaytar


# We place some data in the array to work with
	.data

	.globl	main
	
	.text
main:
    # Call the factorial code
    li $a0 4
    jal Factorial

    j Exit

Exit:
    # syscall to exit()
    li $v0, 10
    syscall

Factorial:
    # int factorial(int n)
    # {
    #     if (n == 0)
    #         return 1;
    #     return n * factorial(n - 1);
    # }

    # Allocate some space on the stack
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    # Check for the basecase
    # If it is the basecase, return 1
    li $v1, 1   # o = 1
    ble $a0, $v1, f_end

    # Call factorial recursively
    addi $a0, $a0, -1  # n--
    jal Factorial      # factorial(n-1)

    # (n - 1)! stored in v0
    # restore previous value of $a0 and $ra
    lw $a0, 0($sp)
    lw $ra, 4($sp)

    # n! = n * (n-1)!
    mul $v1, $v1, $a0

f_end:
    # Return value already stored in return register
    addi $sp, $sp, 8
    jr $ra  # return

