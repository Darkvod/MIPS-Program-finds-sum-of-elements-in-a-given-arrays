# Program File: podprogramy.asm
# Author: Piotr Stêpieñ
# Cel programu: Podprogramy wspó³pracuj¹ce z programem g³owynm.

#PrintNewLine
.text
PrintNewLine:
li $v0,4
la $a0,PNL
syscall
jr $ra
.data
PNL: .asciiz "\n"

# Exit
.text
Exit:
li $v0,10
syscall

# PrintTab
.text
PrintTab:
li $v0,4
la $a0,PT
syscall
jr $ra
.data
PT: .asciiz "\t"

#PrintNewLineP - wersja dla petli
.text
PrintNewLineP:
li $t8,0 	# na potrzeby tylko tego podprogramu jest potrzeba zerowanie t8 
		# jest on dodatkowym iteratorem do wypisywania nowej linii co x iteracji 
li $v0,4
la $a0,PNL_
syscall
j dalsze
.data
PNL_: .asciiz "\n"

# Wczytaj_A - wczytuje macierz A 
.text
wczytaj_A:
move $t1,$a0
cdd:
li $v0, 4       
la $a0, prompt1  	   # wypisanie prompt1: 
syscall  
li $v0,1
move $a0,$t4		   # wypis numeru iteracji
syscall

li $a0, 32             # Za³adowanie do a0 wartoœci 32, w ASCII to spacja
li $v0, 11             # Wydrukowanie znaku spacji dla czytelnoœci wprowadzania
syscall 

li $v0,5		   # odczytanie elementu macierzy
syscall

move $t5,$v0
sb $t5,($t1)		   # zapis inta do tablicy

	   # inkrementacja adresu tablicy
add $t1,$t1,4
addi $t4,$t4,1		   # inkrementacja licznika

beq $t4,$a1,back
j cdd


# Wczytaj_B - wczytuje macierz B 
.text
wczytaj_B:
move $t1,$a0
wczytanko:
li $v0, 4       
la $a0, prompt2  	   # wypisanie prompt2: 
syscall  
li $v0,1
move $a0,$t4		   # wypisanie numeru iteracji(numeruje ktory element podajemy)
syscall

li $a0, 32             # Za³adowanie do a0 wartoœci 32, w ASCII to spacja
li $v0, 11             # Wydrukowanie znaku spacji dla czytelnoœci wprowadzania
syscall 

li $v0,5		   # odczytanie elementu macierzy
syscall
move $t5,$v0

addi $t1,$t1,-4		   # dekrementacja stosu
sb $t5,0($t1)		   # zapis inta do stosu


addi $t4,$t4,1		   # inkrementacja licznika

beq $t4,$a1,back	   # sprawdzenie czy podano juz wystarczajaca ilosc elementow
j wczytanko

.text
back:
jr $ra 		# powrot do main

# proby konwersji

resety:
li $t3,0
li $t7,0
lw $t7,Macierz_A($t3)
bgt $t7,9,reset2
ble $t7,9, reset

resety2:
li $t3,0
li $t7,0
addi $t6,$s6,0
lw $t7,($t6)
bgt $t7,9,reset2
ble $t7,9, reset

resety3:
li $t3,0
li $t7,0
lw $t7,Macierz_C($t3)
bgt $t7,9,reset2
ble $t7,9, reset


reset:
li $t2,0
li $t3,1
nl:
beqz $t3,end		# jesli wczytany element jest 0 to wychodzimy z funkcji
addi $a1,$a1,1		# zwiekszenie adresu w a1
lb $t3,($a0)		# odczytujemy z adresu wskazujacego na a0
sb $t4,($a1)		# zapis 
addi $a1,$a1,1		# inkrementacja w a1
sb $t3,($a1)		# zapis w a1
bne $t2,$s4 next_iteration
sb $t1,($a1)		# zapis newline

j reset
next_iteration:
addi $a0,$a0,1
addi $t2,$t2,1
j nl

end:
jr $ra

reset2:
li $t2,0
li $t3,1
li $t8,2
li $t5,0
mul $s5,$s4,2
nl2:
beqz $t3,end
beq $t5,$t8,spacja
addi $a1,$a1,1
lb $t3,($a0)

sb $t3,($a1)
addi $t5,$t5,1
bne $t2,$s5 next_iteration2
sb $t1,($a1)

j reset2
next_iteration2:
addi $a0,$a0,1
addi $t2,$t2,1
j nl2

spacja:
li $t5,0
addi $a1,$a1,1
sb $t4,($a1)

j nl2
