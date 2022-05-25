;**** WINDLX: Calculul minimului/maximului/sumei cifrelor unui numar ***
;-------------------------------------------------------------------------------------------
;Programul necesita subrutina INPUT.s
; Rezultatele sunt afisate pe consola
;-------------------------------------------------------------------------------------------
.data
Aici:
	.asciiz "aici"
Prompt:
	.asciiz "Introduceti elementul = "
PrintfFormat1:
	.asciiz "Cifra maxima este %d :\n"
PrintfFormat2:
	.asciiz "Cifra minima este %d :\n"
PrintfFormat3:
	.asciiz "Suma cifelor este este %d :\n"
PrintfMesaj_err:
	.asciiz "\nNumar negativ! Reluati!\n"
	.align 2
PrintfPar1:
	.word PrintfFormat1 
PrintfValue1:
	.space 4 
PrintfPar2:
	.word PrintfFormat2 
PrintfValue2:
	.space 4 
PrintfPar3:
	.word PrintfFormat3
PrintfValue3:
	.space 4 
PrintfErr1:
	.word PrintfMesaj_err
.text
.global main
main:
	addi r1,r0,Prompt ; citire de la tastatura a numarului
	jal InputUnsigned ; r1 = retine elementul current al sirului
	sle r15,r1,r0  
	bnez r15, mesaj_err ; daca s-a tastat un numar negativ se afiseaza
						; mesaj urmat de reluarea introducerii
						; numarului de la tastatura	
	addi r2,r1,0 ; r2 = preia numarul
	addi r3,r0,0 ; r3 = va stoca maximul
	addi r4,r0,9 ; r4 = va stoca minimul
	addi r6,r0,0 ; r6 = suma
	addi r7,r0,10 ;impartitorul
loop:
    divu r8,r2,r7
	multu r9,r7,r8
	sub r1,r2,r9
	divu r2,r2,r7
	slt r5,r1,r4 ; daca r1>r4 atunci minimul va deveni ultimul
				 ; element citit
	beqz r5,maxim ; altfel se continua executia fireasca
				  ; comparându-se elementul curent cu maximul
				  ; din sir obtinut pâna în acest moment
	addi r4,r1,0 ; minimul devine ultimul element citit r4 ¬ r1
    maxim:
	sgt r5,r1,r3 ; daca r1>r3 atunci maximul va deveni ultimul
			     ; element citit
	beqz r5,suma ; altfel se continua executia fireasca
				 ; calculându-se suma partiala a elementelor
				 ; din sir citite pâna în acest moment
	addi r3,r1,0 ;maximul devine ultimul element citit r3 ¬ r1
suma:
	add r6,r6,r1 ; r6 ¬ r6 + r1
	bnez r2,loop ; mai sunt cifre?
	sw PrintfValue1,r3 ; salvare parametrii afisare pentru maxim
	addi r14,r0,PrintfPar1
	trap 5 ; afisare maxim
	sw PrintfValue2,r4 ; salvare parametrii afisare pentru minim
	addi r14,r0,PrintfPar2
	trap 5 ; afisare minim
	sw PrintfValue3,r6 ; salvare parametrii afisare pentru suma
	addi r14,r0,PrintfPar3
	trap 5 ; afisare suma
	j gata
mesaj_err:
	sw PrintfValue3,r6 ; salvare parametrii afisare pentru mesaj de
					   ; eroare
	addi r14,r0,PrintfErr1
	trap 5 ; afisare mesaj eroare ‘ Dimensiune sir negativa !’
	j main ; reluare cu tastarea dimensiunii sirului
mesaj_err_el:
	sw PrintfValue3,r6 ; salvare parametrii afisare pentru un al doilea
					   ; mesaj eroare
	addi r14,r0,PrintfErr1
	trap 5 ; afisare mesaj eroare ‘Element negativ!’
	j loop ; reluare cu tastarea elementului curent
gata:
	trap 0 ; încheiere programs