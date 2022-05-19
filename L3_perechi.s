.text
	.globl main
main:
	li $t8,44
	li $t9,41
	geti $t0 		#n<-t0
	li $t1,3 		#t1<-posibile nr prime
	putc 40
	puti $t1		#afisez 2
	putc $t8
	
next:	addi $t1,$t1,1	#urmatorul numar posibil
	li $t3,2
	div $t1,$t3		#impartire la 2 ( nu merge imediat deci folosim t3 ca registru)
	div $t1,$t3
	mflo $t2		#tinem minte catul impartirii
	li $t4,2		# primul divizor
imp:	div $t1,$t4		#impartim la posibil divizor -> restul este in HI
	mfhi $t5		#salvam restul in t5
	beqz $t5,next	#sare la urmatorul numar daca restul este 0 -> numarul nu e prim
	addi $t4,$t4,1	#urmatorul divizor
	blt  $t4,$t2,imp  #sar la next div daca nu am ajuns la jumatatea numarului
	puti $t1		#afisam numarul prim 
	putc $t9
	putc 40
	puti $t1
	
	putc $t8
	addi $t0,$t0,-1	#decrementam n
	bgtz $t0,next	#urmatorul numar de verificat
	done
			
	
	
	

