.data 0x10000480

Array_A:
 .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
 .byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
 .byte 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
 .byte 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
 .byte 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
 .byte 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
 .byte 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
 .byte 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
 .byte 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
 .byte 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
 
 .text
 .globl __start
__start:

 la $2, Array_A
 li $6, 0 					# s - suma li $4, 10 # m - nr. linii din matrice
 li $5, 20 					# n - nr. coloane din matrice
 li $10,0 					# j - indexul pe coloane
loop_j:
							# addi $10, $10, 1
 li $8, 0 					# i - indexul pe linie
loop_i:
							# addi $8, $8, 1
 multu $5,$8 				# $11 <- n * i
 mflo $11


 add $9,$11,$10 			# $9 <- n * i + j
 add $9, $2, $9 			# calculez adresa elementului a[i][j]
 lb $7, 0($9)				# incarcare octet 
 add $6, $6, $7
 addi $8, $8, 1
 blt $8, $4, loop_i			#branch pe conditie strict mai mic
 addi $10, $10, 1
 blt $10, $5, loop_j
 li $v0, 10
 syscall 