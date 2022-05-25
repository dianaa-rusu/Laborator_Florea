.data
Prompt: .asciiz 				"Introduceti numarul n = "
Prompt2: .asciiz 				"Introduceti numarul k = "
PrintfFormat1:	.asciiz 	"Combinari = %g\n\n"
PrintfFormat2:	.asciiz 	"Aranjamente = %g\n\n"
		.align		2
PrintfPar1:
	.word PrintfFormat1
PrintfValue1:
	.space 4 
PrintfPar2:
	.word PrintfFormat2
PrintfValue2:
	.space 4  
.text

__start:

ver_n:addi r1,r0,Prompt 	  #citire de la tastatura a lui n
	  jal InputUnsigned 	  #r1 = n
	  sle r15,r1,r0
	  bnez r15, ver_n     	  #daca s-a tastat un numar negativ se revine la citirea
							  #de pe linia 22
	  add r3,r1,r0			  #r3 = n
	  jal factorial
	  movd f6,f2			  #f6f7 = n factorial
ver_k:addi r1,r0,Prompt2 	  #citire de la tastatura a lui k
	  jal InputUnsigned 	  #r1 = k
	  sle r15,r1,r0
	  bnez r15, ver_k         #daca s-a tastat un numar negativ se revine la citirea
							  #de pe linia 30	
	  add r4,r1,r0			  #r4 = k
	  jal factorial
	  movd f8,f2			  #f8f9 = k!
	  sub r1,r3,r4			  #r1 = (n-k)
	  jal factorial 
	  movd f12,f2			  #f12f13 = (n-k)!
	  divd f6,f6,f12		  #f6f7 = n!/(n-k)! - Aranjamente
	  sd	PrintfValue2,f6   #se afiseaza valoarea si
	  addi	r14,r0,PrintfPar2 #text aranjamente
	  trap	5
	  divd f6,f6,f8		  	  #f6f7=Aranjamente/k! - Combinari
	  sd	PrintfValue1,f6   #se afiseaza valoarea si
	  addi	r14,r0,PrintfPar1 #text combinari
	  trap	5
	  trap 0
	  	
factorial:
		;*** init values
		movi2fp 	f10,r1		#R1 =  D0	D0..Count register
		cvti2d		f0,f10
		addi		r2,r0,1 	#1 = D2	D2..result
		movi2fp		f11,r2
		cvti2d		f2,f11
		movd		f4,f2		#1 = D4 	D4..Constant 1
		
		;*** Break loop if D0 = 1
Loop:		led		f0,f4		#D0<=1 ?
		bfpt		Finish
		
		;*** Multiplication and next loop
		multd		f2,f2,f0
		subd		f0,f0,f4
		j		Loop

Finish: 	;*** return
		jr r31	
		;*** end

	   