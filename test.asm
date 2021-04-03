   .data
fout:   .asciiz "testout.txt"      # filename for output
    .text
# allocate memory for 3 chars + \n, no need to worry about \0
li $v0, 9
li $a0, 4   # allocate 4 bytes for 4 chars
syscall
move $s0, $v0

addi $s0, $s0, 3    # point to the end of the buffer

li $t3, 10      # end line with \n
sb $t3, 0($s0)
addi $s0, $s0, -1
# start witing the number 100 backwars. ascii_to_dec(48) = 0, ascii_to_dec(49) = 1
li $t3, 48
sb $t3, 0($s0)
addi $s0, $s0, -1   # move the pointer backwards, meaning you go from the end to the beginning

li $t3, 48
sb $t3, 0($s0)
addi $s0, $s0, -1

li $t3, 49
sb $t3, 0($s0)

# Open (for writing) a file that does not exist
li   $v0, 13       # system call for open file
la   $a0, fout     # output file name
li   $a1, 1       # Open for writing (flags are 0: read, 1: write)
li   $a2, 0        # mode is ignored
syscall            # open a file (file descriptor returned in $v0)
move $s6, $v0      # save the file descriptor 

# Write to file just opened
li   $v0, 15       # system call for write to file
move $a0, $s6      # file descriptor 
move $a1, $s0      # address of buffer from which to write
li   $a2, 4        # hardcoded buffer length
syscall            # write to file

# Close the file 
li   $v0, 16       # system call for close file
move $a0, $s6      # file descriptor to close
syscall            # close file