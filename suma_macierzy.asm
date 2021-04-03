# Program File: suma_macierzy.asm
# Author: Piotr Stêpieñ
# Cel programu: Uzytkownik podaje rozmiar oraz wartosci dwóch macierzy a program oblicza ich sumê.
 
.data
prompt1: .asciiz "Podaj elementy macierzy A, nr elementu: "
prompt2: .asciiz "Podaj elementy macierzy B, nr elementu: "
MacA: .asciiz "\nMacierz[A]:\n "
MacB: .asciiz "\nMacierz[B]:\n "
prompt3: .asciiz "\nMacierz[C]:\n "
prompt4: .asciiz "Podaj ilosc wierszy macierzy: "
prompt5: .asciiz "Podaj ilosc kolumn macierzy: "         
.align 4 # wyrownanie adresu do 4(bo elementy tablicy sa zapisywane co 4 bajty // byl blad przy instrukcji sw
Macierz_A: .space 100  			# Przygotowanie miejsca na dane dla Macierzy A
.align 4 # wyrownanie adresu do 4(bo elementy tablicy sa zapisywane co 4 bajty // byl blad przy instrukcji sw
Macierz_C: .space 100  			# Przygotowanie miejsca na dane dla Macierzy A


.globl main
.text
main:   

lb $t1,($0)

li $v0, 4       
la $a0, prompt4  	   # prosba o podanie z ilu wierszy sklada sie macierz 
syscall

li $v0,5		   # odczytanie liczby wierszy
syscall

move $s3,$v0		# pzreniesienie wprowadzonej wartosci

li $v0, 4       
la $a0, prompt5  	   # prosba o podanie z ilu kolumn sklada sie macierz 
syscall

li $v0,5		   # odczytanie liczby kolumn
syscall

move $s1,$v0		# przeniesienie wprowadzonej wartosci

move $s4,$s1		# przeniesienie ilosci kolumn do $s4 - uzywane do beq - newline w petli

mul $s1,$s1,$s3		# ilosc elementow macierzy(np. podano 2wiersze i 3kolumny  czyli 2x3)
add $s1,$s1,1		   # przygotowanie rejetru do ktorego bede prownywal iterator w petlach, zwiekszenie o 1 bo iteracje zaczynam od 1, nie od 0 

li $t4, 1      	   # Zerowanie t4, który bêdzie s³u¿y³ jako iterator

    		   		   
move $a1,$s1
la $a0,Macierz_A
jal wczytaj_A	   # wczytujemy Macierz_A

la $t1,out1
la $t3,Macierz_A
jal reverse		   		       		   		      		   		   
		   
    
li $t4, 1      	   # Zerowanie t4, który bêdzie s³u¿y³ jako iterator
li $t3,0
jal kon     
               
jal PrintNewLine 	   # Skok do podprogramu wykonuj¹cego now¹ liniê

    
move $a1,$s1
move $a0,$sp        
jal wczytaj_B	   # Wczytywanie Macierzy_B


move $s6,$t1
move $t3,$t1
la $t1,out2
jal reverse2    			   
    			       			       			   
li $v0, 4       
la $a0, prompt3  	   # wypisanie stringa: Macierz[C]: 
syscall         
    
li $t4, 1      	   # Zerowanie t4, który bêdzie s³u¿y³ jako iterator
    
    
jal PrintNewLine 	   # Skok do podprogramu wykonuj¹cego now¹ liniê
    


li $t2,1
jal kon2    

   
         
mul $s2,$s1,4		# obliczanie wartosci potrzebnych do przywrocenia stosu, zalezne od s1 czyli ilosci iteracji * 4
add $s2,$s2,-8	   # obliczenia potrzebne do poprawnego przywrocenia stosu // -8 (bo iteracja jest zwiekszona o 1, oraz aby wskazywa³o na 1 element stosu )
add $s6,$s6,$s2	   # przywrocenie stosu przed wejsciem w pêtle            
move $t3,$s6                              
addi $t1,$0,0	   # wyzerowanie miejsca od ktorego zczytuje tablice macierzy A

li $t2,0
la $a0,Macierz_A     
j while          	   # skok do pêtli


while:
move $t1,$a0

dalsze:
beq $t4, $s1, zapis_do_pliku 	   # jeœli wykonano 9 iteracji to wychodzimy z programu
beq $t8,$s4,PrintNewLineP # Co $s4 iteracje wypisywana jest nowa linia (tak aby macierz C nie by³a wypisana w jednej linii)
lw $t5, ($t1)         # odczytanie  wartoœci zapisanej w tablicy Macierz_A w miejscu ktore wskazuje t1 i zapisanie jej do t5
lw $t6, ($t3)         # odczytanie wartoœci ze stosu

add $t7, $t5, $t6      # sumowanie wartoœci odczytanych w poprzednich dwóch instrukcjach

sw $t7,Macierz_C($t2)

add $t8,$t8,1   	   # Inkrementacja dodatkowego iteratora obs³uguj¹cego newline
    
li $v0, 1             
move $a0, $t7          # Wypisanie wartoœci w t7 (czyli sumy kolejnych elementów macierzy A i B)
syscall         

li $a0, 32             # Za³adowanie do a0 wartoœci 32, w ASCII to spacja
li $v0, 11             # Wydrukowanie znaku spacji dla czytelnoœci wyniku
syscall         

addi $t2, $t2, 4
addi $t1, $t1, 4       # inkrementacja adresu w $t1 o 4 - adres inkrementuje siê o 4 bajty, czyli do kolejnej wartoœci
addi $t3, $t3, -4       # inkrementacja adresu w $t2 o 4 - adres inkrementuje siê o 4 bajty, czyli do kolejnej wartoœci
addi $t4, $t4, 1       # inkrementacja iteratora pêtli

j dalsze                 # powrót do pêtli

.include "podprogramy.asm"
.include "wyjatki.asm"  
.include "zadanie5.asm"
.include "int2str.asm"
