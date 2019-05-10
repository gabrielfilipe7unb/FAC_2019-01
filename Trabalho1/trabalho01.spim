# Gabriel Filipe Manso Araujo - 16/0121019
# Guilherme Antonio Deusdar‡ Banci - 16/0122996

# FAC: TRABALHO 01

      .data
      
space:		.asciiz  " "          # space
new_line:	.asciiz  "\n"         # newline
string_ADD:	.asciiz  "ADD: "
string_SUB:	.asciiz  "\nSUB: "
string_AND:	.asciiz  "\nAND: "
string_OR:	.asciiz  "\nOR: "
string_XOR:	.asciiz  "\nXOR: "
string_SLL:	.asciiz  "\nSLL(3): "
string_SRL:	.asciiz  "\nSRL(1): "

      .text
      
main:
	li $v0, 5	# load appropriate system call code into register $v0;
			# code for reading integer is 5
	syscall		# call operating system to perform operation
	move $a0, $v0	# O PRIMEIRO VALOR LIDO DO TECLADO ESTA DISPONIVEL EM $A0
	li $v0, 5	# load appropriate system call code into register $v0;
			# code for reading integer is 5
	syscall		# call operating system to perform operation
	move $a1, $v0	# O SEGUNDO VALOR LIDO DO TECLADO ESTA DISPONIVEL EM $A1
      
# =================== IMPLEMENTE AQUI SUA SOLUCAO: INICIO

	add $t0, $a0, $a1  # Adding the values into register $a0 and $a1 and putting result into $t0
	sub $t1, $a0, $a1  # Subtracting the values into register $a0 and $a1 and putting result into $t1
	and $t2, $a0, $a1  # Making AND operation with the values into register $a0 and $a1 and putting result into $t2
	or $t3, $a0, $a1   # Making OR operation with the values into register $a0 and $a1 and putting result into $t3
	xor $t4, $a0, $a1  # Making XOR operation with the values into register $a0 and $a1 and putting result into $t4
	sll $t5, $a0, 3
	srl $t6, $a1, 1

# =================== IMPLEMENTE AQUI SUA SOLUCAO: FIM      

      jal  print            # call print routine. 
      li   $v0, 10          # system call for exit
      syscall               # we are out of here.
		

print:	

	la   $a0, string_ADD  
      	li   $v0, 4		# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t0      	# 
	li   $v0, 1           	# specify Print Integer service
      	syscall               	# print $t0: ADD
      	
      	
	la   $a0, string_SUB   	# load address of print heading
      	li   $v0, 4           	# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t1      	# 
	li   $v0, 1           	# specify Print Integer service
      	syscall               	# print $t1: SUB
      	
      	
	la   $a0, string_AND   	# load address of print heading
      	li   $v0, 4           	# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t2      	# 
	li   $v0, 1           	# specify Print Integer service
      	syscall               	# print $t2: AND
      	
      	
	la   $a0, string_OR   	# load address of print heading
      	li   $v0, 4           	# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t3      	# 
	li   $v0, 1           	# specify Print Integer service
      	syscall               	# print $t3: OR      
      	
      			
	la   $a0, string_XOR   	# load address of print heading
      	li   $v0, 4           	# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t4      	# 
	li   $v0, 1           	# specify Print Integer service
      	syscall               	# print $t4: XOR
      	
      	
      	la   $a0, string_SLL   	# load address of print heading
      	li   $v0, 4           	# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t5      	# 
	li   $v0, 1           	# specify Print Integer service
      	syscall               	# print $t5: SLL
      	
      	
      	la   $a0, string_SRL   	# load address of print heading
      	li   $v0, 4           	# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t6      	# 
	li   $v0, 1           	# specify Print Integer service
      	syscall               	# print $t6: SRL
      	
	la   $a0, new_line  
      	li   $v0, 4		# specify Print String service
      	syscall               	# print 
      	
	jr   $ra              	# return
	
