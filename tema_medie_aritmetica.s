.data
	n: .word 6 #cate numere vreau sa adune
	n_def: .word 1, 2, 4, 12, 9, 6 #numerele cu care vrem sa facem media
	ret_adr: .word 0x10010030
	mesaj_suma: .asciiz "Suma este: "
	mesaj_cat: .asciiz "\nCatul este:  "
	mesaj_rest: .asciiz "\nRestul este: "
	
.globl main
.text 

main:
	lw $t0, n # aducem n din memorie sa stim cate numere avem
	la $t1, n_def  #aducem adresa tabloului intr-un registru
	xor $t2,  $t2, $t2 #suma
	
for: lw $t3, ($t1)
	 add $t2, $t2, $t3
	 addi $t1, 4  #trecem la urmatorul numar
	 addi $t0, $t0, -1 #decrementam n-ul
	 bgtz $t0, for #facem adunarea cat timp avem n
	 
lw $t0, ret_adr
sw $t2, ($t0) 

lw $t0, n 
div $t2, $t0 #facem impartirea  

mflo $t4 #in $t0 salvam catul
mfhi $t5 #in $t1 salvam restul

li $v0, 4 #codul de la print string 
la $a0, mesaj_suma #isi ia adr string-ului si ret pana la null
syscall

li $v0, 1  #1=print int
move $a0, $t2
syscall 

li $v0, 4 #codul de la print string 
la $a0, mesaj_cat #isi ia adr string-ului si ret pana la null
syscall

li $v0, 1
move $a0, $t4
syscall

li $v0, 4 #codul de la print string 
la $a0, mesaj_rest #isi ia adr string-ului si ret pana la null
syscall

li $v0, 1
move $a0, $t5
syscall
