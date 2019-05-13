# Gabriel Filipe Manso Araujo - 16/0121019

# FAC: TRABALHO 02

.data

initial_print1:		.asciiz  "Digite o dividendo: "
initial_print2:		.asciiz  "Digite o divisor: "
formula:		.asciiz  "Formula: "
formula_with_result:	.asciiz	 "Formula com o resultado: "
resto:			.asciiz  "Resto: "
space:			.asciiz  " "          
new_line:		.asciiz  "\n"         
division_simbol:	.asciiz	 "/"
equal_simbol:		.asciiz	 "="
erro:			.asciiz  "Impossivel realizar divisao na formula: "
return:			.asciiz  "Retorno: "

.text
.globl main

# =================== TESTES DE ENTRADA/SAIDA

#ENTRADA
####Digite o dividendo: -2
####Digite o divisor: 0

#SAIDA
####Impossivel realizar divisao na formula: -2/0
####Retorno: 1

#ENTRADA
####Digite o dividendo: -7
####Digite o divisor: 2

#SAIDA
####Formula: -7/2
####Formula com o resultado: -7/2 = -3
####Resto: -1
####Retorno: 0

#ENTRADA
####Digite o dividendo: 0
####Digite o divisor: 3

#SAIDA
####Formula: 0/3
####Formula com o resultado: 0/3 = 0
####Resto: 0
####Retorno: 0

#ENTRADA
####Digite o dividendo: 29
####Digite o divisor: 5

#SAIDA
####Formula: 29/5
####Formula com o resultado: 29/5 = 5
####Resto: 4
####Retorno: 0

#ENTRADA
####Digite o dividendo: 79
####Digite o divisor: 5

#SAIDA
####Formula: 79/5
####Formula com o resultado: 79/5 = 15
####Resto: 4
####Retorno: 0


main:

# =================== INICIACAO DE VALORES
	
	li $t1,0			#Hi(RESTO) auxiliar
	li $t2,0			#Lo(RESTO)
	li $t4,0 			#Contador       
	li $t5,32  			#Comparador passo 5
	li $t6,0  			#Resto
	li $t7,0			#Hi(RESTO)

# =================== LEITURA DE VALORES

	la   $a0, initial_print1   	
      	li   $v0, 4           	
      	syscall               	

	li $v0, 5	
	syscall		
	move $s0, $v0			# O PRIMEIRO VALOR LIDO DO TECLADO ESTA DISPONIVEL EM $S0
	
	la   $a0, initial_print2   	
      	li   $v0, 4           	
      	syscall               	
	
	li $v0, 5	
	syscall		
	move $s1, $v0			# O DIVISOR ESTA DISPONIVEL EM $S1
	
	la   $a0, new_line  
      	li   $v0, 4		
      	syscall     
      
# =================== CHAMA A FUNCAO divfac na main
	
	jal  divfac
	
# =================== CHAMA A FUNCAO PRINT na main
	
	jal  PRINT
	
# =================== ALGORITMO DA DIVISAO
	
divfac: 

	addi $sp, $sp, -8
	sw $s1, 4 ($sp)
	sw $s0, 0 ($sp)
	
	beq $s1,$zero,ERRO
	
	slt $t3,$s0,$zero
	bne $t3,$zero,MULT_S
	add  $t6,$s0,$zero
	
	
PASSO_1:
	
	addi $t4,$t4,8		#Contador = 1
	
#PASSO_2: 
	sll  $t6,$t6,1	 	 #Resto atualizado
	srl  $t7,$t6,4
	add  $t1,$t7,$zero	
	sll  $t7,$t7,4
	sub  $t2,$t6,$t7	#Lo(RESTO) atualizado
	move $t7,$t1		#Hi(RESTO) atualizado
	 
PASSO_3:

	sub  $t7,$t7,$s1
	add  $t1,$t7,$zero	#Auxiliar Hi(RESTO)
	sll  $t7,$t7,4
	add  $t6,$t7,$t2  	#Resto atualizado
	move $t7,$t1		#Hi(RESTO) atualizado
	
#PASSO_4:

	bgez $t7,PASSO_4.1	#Se Hi(RESTO) >= 0
	
#PASSO_4.2:

	add  $t7,$t7,$s1
	add  $t1,$t7,$zero
	sll  $t7,$t7,4
	add  $t6,$t7,$t2 	#Resto atualizado
	move $t7,$t1		#Hi(RESTO) atualizado
	
	sll  $t6,$t6,1		#Resto atualizado - SLL 1 bit
	
	srl  $t7,$t6,4
	add  $t1,$t7,$zero
	sll  $t7,$t7,4
	sub  $t2,$t6,$t7 	#Lo(RESTO) atualizado
	move $t7,$t1		#Hi(RESTO) atualizado

PASSO_5: 
	addi $t4,$t4,8		#Contador = Contador + 1
	slt $t0,$t5,$t4		#Se 32 < Contador
	bne $t0,$zero,PASSO_6	#Se 32 <= Contador
	j PASSO_3

PASSO_4.1: 

	sll  $t6,$t6,1		#Resto atualizado - SLL 1 bit
	addi $t6,$t6,1		#Resto com bit menos significativo igual a 1
	srl  $t7,$t6,4
	add  $t1,$t7,$zero	
	sll  $t7,$t7,4
	sub  $t2,$t6,$t7	#Lo(RESTO) atualizado
	move $t7,$t1		#Hi(RESTO) atualizado
	
	j PASSO_5
	
PASSO_6:

	srl  $t7,$t7,1		#SRL 1bit no Hi(RESTO)
	
	bltz $s0,RESULT_S
	
MOVE_TO_LO_HI:
	
	mtlo $t2
	mthi $t7
	
	lw $s0, 0 ($sp)
	lw $s1, 4 ($sp)
	addi $sp, $sp, 8
	
	jr   $ra
	
MULT_S:

	mul $t6,$s0,-1
	
	j PASSO_1
	
RESULT_S:

	mul $t2,$t2,-1
	
	mul $t7,$t7,-1
	
	j MOVE_TO_LO_HI
		
	
	
PRINT:
          
# =================== FORMULA SEM RESULTADO

 	la $a0 formula
	li $v0,4
	syscall
	
	move   $a0, $s0
	li   $v0, 1           	
      	syscall               	
      	
      	la   $a0, division_simbol   	
      	li   $v0, 4           	
      	syscall               	
      	
      	move   $a0, $s1      	 
	li   $v0, 1           	
      	syscall               	               	
	
	la   $a0, new_line  
      	li   $v0, 4		
      	syscall        
      	
      	la   $a0, new_line  
      	li   $v0, 4		
      	syscall

# =================== FORMULA COM RESULTADO

      	la $a0 formula_with_result
	li $v0,4
	syscall
	
	move   $a0, $s0
	li   $v0, 1           	
      	syscall               	
      	
      	la   $a0, division_simbol   	
      	li   $v0, 4           	
      	syscall               	
      	
      	move   $a0, $s1      	 
	li   $v0, 1           	
      	syscall               	
      	
      	la   $a0, space   	
      	li   $v0, 4           	
      	syscall               	
      	
      	la   $a0, equal_simbol   	
      	li   $v0, 4           	
      	syscall               	
	
	la   $a0, space   	
      	li   $v0, 4           	
      	syscall               	
      	
      	mflo   $t2
      	move   $a0, $t2      	
	li   $v0, 1           	
      	syscall               	
	
	la   $a0, new_line  
      	li   $v0, 4		
      	syscall

# =================== RESTO
    	        	
      	la   $a0, resto   	
      	li   $v0, 4           	
      	syscall
      	
      	mfhi   $t2
      	move   $a0, $t7      	
	li   $v0, 1           	
      	syscall	
		
	la   $a0, new_line  
      	li   $v0, 4		
      	syscall
      	
      	la   $a0, new_line  
      	li   $v0, 4		
      	syscall
      	
# =================== RETORNO
      	   
      	la   $a0, return   	
      	li   $v0, 4           	
      	syscall  
      	
      	move $a0,$zero	
      	li   $v0, 1           	
      	syscall 
      	
     	la   $a0, new_line  
      	li   $v0, 4		
      	syscall
      	
# =================== FIM DO PROGRAMA
      	
      	li $v0, 10            
	syscall
	
ERRO:

# =================== MENSAGEM DE ERRO

	la   $a0, erro   	
      	li   $v0, 4           	
      	syscall	
		
	move   $a0, $s0
	li   $v0, 1           	
      	syscall               	
      	
      	la   $a0, division_simbol   	
      	li   $v0, 4           	
      	syscall               	
      	
      	move   $a0, $s1      	 
	li   $v0, 1           	
      	syscall               	               	
	
	la   $a0, new_line  
      	li   $v0, 4		
      	syscall  
      	
       	la   $a0, new_line  
      	li   $v0, 4		
      	syscall     
      	
# =================== RETORNO      	
      	
      	la   $a0, return   	
      	li   $v0, 4           	
      	syscall    
      	
      	addi $t3,$t3,1
      	
      	move   $a0, $t3      	 
	li   $v0, 1           	
      	syscall 
      	
     	la   $a0, new_line  
      	li   $v0, 4		
      	syscall 
      	
# =================== FIM DO PROGRAMA
      	
      	li $v0, 10            
	syscall