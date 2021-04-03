# Program File: zadanie5.asm
# Author: Piotr Stêpieñ
# Cel programu: Program kopiuje zawartosc pliku wejsciowego do pliku wyjsciowego 

.data
plik_out: .asciiz "output.txt"
prompt: .asciiz "Blad otwarcia pliku"
po_konwersji1: .space 100
po_konwersji2: .space 100
po_konwersji3: .space 100

.text
zapis_do_pliku:
li $t2,0
li $t3,0

la $t1,out3
la $t3,Macierz_C

jal reverse

li $t3,0
jal kon3


## proby konwersji
la $a0,str
la $a1,po_konwersji1 
li $t2,0 # iterator
li $t1,0xA
li $t3,1
li $t4,0x20
sb $t1,($a1) # zaczynam od newline

li $t3,0

jal resety

la $a0,str2
la $a1,po_konwersji2 
li $t2,0 # iterator
li $t1,0xA
li $t3,1
li $t4,0x20
sb $t1,($a1) # zaczynam od newline

jal resety2

la $a0,str3
la $a1,po_konwersji3 
li $t2,0 # iterator
li $t1,0xA
li $t3,1
li $t4,0x20
sb $t1,($a1) # zaczynam od newline

jal resety3


# Otwieranie pliku wyjsciowego
li   $v0, 13       # system call dla otwarcia pliku
la   $a0, plik_out      # nazwa pliku wyjsciowego
li   $a1, 1        # jesli a1 = 1 to plik jest tylko do zapisu z utworzeniem pliku
syscall            
move $s6, $v0      # przeniesienie deskryptora do s6


# Zapis do pliku
li   $v0, 15       # system call do zapisu w pliku
move $a0, $s6      # przeniesienie deskryptora do a0
la   $a1, MacA    # ladowanie adresu bufora ktory przechowuje zawartosc wejscia
li   $a2, 12      # liczba znakow do zapisu
syscall

# Zapis do pliku
li   $v0, 15       # system call do zapisu w pliku
move $a0, $s6      # przeniesienie deskryptora do a0
la   $a1, po_konwersji1    # ladowanie adresu bufora ktory przechowuje zawartosc wejscia
addi $a2,$s1,20      # liczba znakow do zapisu
syscall

# Zapis do pliku
li   $v0, 15       # system call do zapisu w pliku
move $a0, $s6      # przeniesienie deskryptora do a0
la   $a1, MacB    # ladowanie adresu bufora ktory przechowuje zawartosc wejscia
li   $a2, 12      # liczba znakow do zapisu
syscall

# Zapis do pliku
li   $v0, 15       # system call do zapisu w pliku
move $a0, $s6      # przeniesienie deskryptora do a0
la   $a1, po_konwersji2    # ladowanie adresu bufora ktory przechowuje zawartosc wejscia
addi $a2,$s1,20      # liczba znakow do zapisu
syscall           

# Zapis do pliku
li   $v0, 15       # system call do zapisu w pliku
move $a0, $s6      # przeniesienie deskryptora do a0
la   $a1, prompt3    # ladowanie adresu bufora ktory przechowuje zawartosc wejscia
li   $a2, 12      # liczba znakow do zapisu
syscall

# Zapis do pliku
li   $v0, 15       # system call do zapisu w pliku
move $a0, $s6      # przeniesienie deskryptora do a0
la   $a1, po_konwersji3    # ladowanie adresu bufora ktory przechowuje zawartosc wejscia
addi $a2,$s1,20     # liczba znakow do zapisu
syscall

# Zamkniecie pliku
li   $v0, 16       # system call dla zamkniecia pliku
move $a0, $s6      # przeniesienie deskryptora do a0
syscall            


li $v0,10 	   # koniec programu
syscall

.text
blad:
li $v0, 55       
la $a0, prompt  	   # powiadomienie o bledzie 
syscall
li $v0,10	# koniec programu
syscall

# Problem by³ taki, ¿e w zadaniu jest napisane, ¿e nazwy programów musz¹ byæ podawane przez u¿ytkownika 
# program dzia³a³ gdy zadeklarowa³em nazwy plikow wewn¹trz programu, ale nie dzia³a³ gdy podawa³em je jako u¿ytkownik.
# Przy pracy w trybie krokowym zauwa¿y³em, ¿e w momencie gdy podajê String  w pamiêci zapisywany jest on z koñcówk¹
# 0x0000000a, która (prawdopodobnie) w jakiœ sposób oznacza dla pamiêci koniec tego stringa(<- tego zdania nie jestem pewien), 
# ale jednoczenie uniemo¿liwia dzia³anie programu z zamys³em ¿e podaje nazwy pliku jako String w trakcie dzia³ania programu,  
# dlatego zastanowi³em siê jak utworzyæ funkcjê, która usuwa³aby t¹ wartoœæ 0x0000000a - rezultat widaæ ni¿ej.

#usunsyf:    
#beq $t0, $t1, powrot    # jesli ilosc iteracji = maksymalna ilosc znakow to powrot
#lb $t3, plik1($t0)      # wczytanie bajtu (chara)
#bne $t3, 0x0000000a, iteracja # jesli nie jest rowny 0x0a to kolejna iteracja
#sb $zero, plik1($t0)    # jesli trafimy na 0x0000000a to wpisujemy tu 0
#iteracja:
#addi $t0, $t0, 1   # zwiekszenie iteratora o 1 (bo chary zajmuj¹ 1 bajt)
#j usunsyf
#powrot:
#jr $ra

# ta sama pêtla co wy¿ej tylko dla pliku2
#usunsyf_:
#beq $t0, $t1, powrot_
#lb $t3, plik2($t0)
#bne $t3, 0x0a, iteracja_
#sb $zero, plik2($t0)
#iteracja_:
#addi $t0, $t0, 1
#j usunsyf_
#powrot_:
#jr $ra

