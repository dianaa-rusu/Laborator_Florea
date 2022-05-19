.data
	msg_afisare_n: .asciiz "n = "
	msg_citire_nr: .asciiz "Introduceti numerele: "
	msg_afisare_vector_sortat: .asciiz "Vectorul sortat este: "
	.align 4
	n: .space 4
	vector: .space 100

.text
.globl main

main:
	li $v0, 4
	la $a0, msg_afisare_n
	syscall

	li $v0, 5
	syscall
	move $a1, $v0
	la $t0, n		#memoram n
	sw $a1, ($t0)	#meoram cuvantul de la adresa t0

	li $v0, 4
	la $a0, msg_citire_nr   #citim numerele
	syscall
	la $t0, vector		#$t0<-adresa vectorului 
	move $t1, $a1		#contor numere citite	
		
citeste:
	li $v0, 5
	syscall
	sw $v0, ($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	bgtz $t1, citeste

	jal bubble_sort		#jump si salvam legatura
	
	li $v0, 4
	la $a0, msg_afisare_vector_sortat
	syscall
	
	la $t0, vector		#salvam adresa vectorului 
	
repeta:
	lw $a0, ($t0)		#afisam a[i]
	li $v0, 1
	syscall 
	putc ' '
	addi $t0, $t0, 4
	addi $a1, $a1, -1
	bgtz $a1, repeta

	done

bubble_sort:
	li $t1, 1		
	move $t2, $a1		#salvam n in t2
	
for1:
	li $t3, 0			#t3 = 0
	move $t4, $a1		#t4 = n - 1
	addi $t4, $t4, -1	
	la $t0, vector		#incarcam adresa vectorului
	
for2:
	lw $t5, ($t0)		#t5 = a[i]
	lw $t6, 4($t0)		#t6 = a[i+1]
	sgt $t7, $t5, $t6	#setam flag pe relatia de >
	beqz $t7, continua
	
interschimbare:
	sw $t6, ($t0)     
	sw $t5, 4($t0)
	
continua:
	addi $t0, $t0, 4	#urmatorl element
	addi $t3, $t3, 1	
	slt $t7, $t3, $t4	#seteaza flag pe relatia de <
	bnez $t7, for2
	
	addi $t1, $t1, 1
	slt $t7, $t1, $t2
	bnez $t7, for1		#branch de neegalitate

	jr $ra				#jump la adresa din registrul a 
