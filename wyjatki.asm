# Program File: wyjatki.asm
# Author: Piotr Stêpieñ
# Cel programu: Obsluga wyjatkow.

.ktext 0x80000180

move $k0, $at           # $k0 = $at
la $k1, _regs           # $k1 = adres _regs
sw $k0, 0($k1)          # zapisz $at
sw $v0, 4($k1)          # zapisz $v0
sw $a0, 8($k1)          # zapisz $a0

la $a0, _msg1           # $a0 = adres _msg1
li $v0, 4               # $v0 = us³uga 4
syscall                 # Print _msg1
mfc0 $a0, $14           # $a0 = EPC
li $v0, 34              # $v0 = us³uga 34
syscall                 # print EPC szesnastkowo


mfc0 $a0, $13           # $a0 = przyczyna
srl $a0, $a0, 2         # przesun w prawo o 2 bity
andi $a0, $a0, 31       # $a0 = kod wyj¹tku

beq $a0,4,addr
beq $a0,5,addr

cd:
la $a0, _msg2           # $a0 = adres _msg2
li $v0, 4               # $v0 = us³uga 4
syscall                 # Print _msg2
mfc0 $a0, $13           # $a0 = przyczyna
srl $a0, $a0, 2         # przesun w prawo o 2 bity
andi $a0, $a0, 31       # $a0 = kod wyj¹tku
li $v0, 1               # $v0 = us³uga 1
syscall                 # Print kod wyj¹tku
la $a0, _msg3           # $a0 = adres _msg3
li $v0, 4               # $v0 = us³uga 4
syscall                 # Print _msg3
la $k1, _regs           # $k1 = adres  _regs
lw $at, 0($k1)          # odtwórz $at
lw $v0, 4($k1)          # odtwórz $v0
lw $a0, 8($k1)          # odtwórz $a0
mtc0 $zero, $8          # wyczyœæ vaddr
mfc0 $k0, $14           # $k0 = EPC
addiu $k0, $k0, 4       # Zwiêksz $k0 o 4
mtc0 $k0, $14           # EPC = wska¿ nastepn¹ instrukcj¹
eret                    # powrót z wyj¹tku: PC = EPC
                        # j¹dro danych jest zapisany tutaj
addr:
li $v0, 4               # $v0 = us³uga 4
la $a0, _msg4           # $a0 = adres _msg1
syscall                 # Print _msg4

li $v0, 34              # $v0 = us³uga 34
mfc0 $a0, $8           # $a0 = vaddr
syscall   

j cd

.kdata
_msg1: .asciiz "\n Wyjatek spowodowany instrukcja spod adresu: "
_msg2: .asciiz "\n Kod wyjatku = "
_msg3: .asciiz "\n Zignoruj i kontynuuj program ...\n"
_msg4: .asciiz "\n Niepoprawny vaddr: "
_regs: .word 0:3        # Miejsce do rezerwowania rejestrow
