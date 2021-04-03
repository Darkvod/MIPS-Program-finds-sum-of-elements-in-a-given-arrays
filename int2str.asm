.data
str: .space 100 # str = 10 znakow
str2: .space 100 # str = 10 znakow
str3: .space 100
out1: .space 100
out2: .space 100
out3: .space 100
.text
kon:
la $s0,str		# do tego stringa zapisuje
addi $s3,$s1,-1		
add $s0,$s0,$s3		# adres koncowy stringa str
li $a1,10

li $t7,0
lw $t7,Macierz_A($t3)	# odczyt wartosci z macierzyA
ble $t7,9,konwersja	# sprawdzenie czy trzeba zwiekszyc ilosc iteracji
add $s0,$s0,$s3		# zwiekszenie iteracji
konwersja:
beq $t3,$s1,back	# if (i==n) then back
lb $a0,out1($t2)
addi $t3,$t3,1	 	# i++
add $t2,$t2,4		# inkrementacja adresu


int2str:		# funkcja int2str z Laboratorium 8
divu $a0,$a1
mflo $a0
mfhi $t0
addiu $t0,$t0,48
addiu $s0,$s0,-1
sb $t0,($s0)
bnez $a0,int2str
j konwersja



kon2:
li $t3,0
la $s0,str2
addi $s3,$s1,-1
add $s0,$s0,$s3
li $a1,10

addi $t6,$s6,4
lw $t7,($t6)
ble $t7,9,konwersja2
add $s0,$s0,$s3
konwersja2:
beq $t2,$s1,back
lb $a0,out2($t3)
addi $t2,$t2,1		   # inkrementacja licznika
add $t3,$t3,4

int2str2:
divu $a0,$a1
mflo $a0
mfhi $t0
addiu $t0,$t0,48
addiu $s0,$s0,-1
sb $t0,($s0)
bnez $a0,int2str2
j konwersja2


kon3:
la $s0,str3
addi $s3,$s1,-1
add $s0,$s0,$s3
li $a1,10

lw $t7,Macierz_C($t3)
ble $t7,9,konwersja3
add $s0,$s0,$s3
konwersja3:
beq $t3,$s1,back
lb $a0,out3($t2)
addi $t3,$t3,1		   # inkrementacja licznika
add $t2,$t2,4

int2str3:
divu $a0,$a1
mflo $a0
mfhi $t0
addiu $t0,$t0,48
addiu $s0,$s0,-1
sb $t0,($s0)
bnez $a0,int2str3
j konwersja3


reverse:
li	$t0, 0			#  t0 

mul $s5,$s1,4			# t3 wskazuje na adres macierzy,
add $s5,$s5,-8			# obliczamy wskaznik na koniec tej macierzy
add $t3,$t3,$s5			# tak aby zapisaæ j¹ odwrotnie
		
reverse_loop:

lb	$t4, 0($t3)		# odczyt z pamieci
beqz	$t4, back		# jesli wczytujemy 0 to wychodzimy z funkcji
sb	$t4, 0($t1)		# zapisujemy w miejscu na ktore wskazuje t1, czyli do nowej tablicy, ale na pierwszej pozycji
subi	$t3, $t3, 4		# j--, dekrementacja adresu macierzy ktora wczytujemy
addi	$t1, $t1, 4		# input arr
addi	$t0, $t0, 1		# i++
j	reverse_loop		




# wersja dzia³ajaca ze stosem
reverse2:
li	$t0, 0			
		
reverse_loop2:

lb	$t4, 0($t3)		
beqz	$t4, back		
sb	$t4, 0($t1)		
addi	$t3, $t3, 4		# j--
addi	$t1, $t1, 4		# input arr
addi	$t0, $t0, 1		# i++
j	reverse_loop2		





