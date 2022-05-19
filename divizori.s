.data

	date: .space 100
	citire_n: .asciiz "n="
	putere: .asciiz " la puterea "

.globl main
.text

main:
		puts citire_n #afisez n=
		geti $a2
		la $t2, date
		li $a3, 1 #contor divizori
		li $a1, 2 #divizor curent
		li $t1, 1 #compar n cu 1 la iesirea din repeat
		li $t3, 0 
		
repeat:
		
		div $a2, $a1
		mfhi $t0 #punem restul in t0
		bnez $t0, exit_loop
		sw $a1, ($t2)
		add $t2, $t2, 4
		add $t3, $t3, 1
		mflo $a2
		j repeat

exit_loop: bnez $t3, afisare # daca t3 e diferit de 0 afisez divizor ($a1) la puterea ($t3)

continue: add $a1, $a1, 1
		  bne $a2, $t1, repeat
		  done
		  
afisare: puti $a1
		 puts putere
		 puti $t3
		 putc '\n'
		 li $t3, 0
		 j continue