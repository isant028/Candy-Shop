.data 
str0: .asciiz "Welcome to BobCat Candy, home to the famous BobCat Bars!\n"
# Declare any necessary data here
price: .asciiz "Please enter the price of a Bobcat Bar: "
wrap: .asciiz "Please enter the number of a wrappers needed to exchange for a new bar: "
amount: .asciiz "Please enter the amount: "
prog: .asciiz "Good! Let me run the number...\n"
first: .asciiz "You first buy "
iter: .asciiz "Then, you will get another "
final: .asciiz "With $"
final2: .asciiz ", you will receive a maximum of "
bars: .asciiz " bars.\n"   
bbars: .asciiz " Bobcat Bars!\n"


.text
		li $v0, 4	#intro 
		la $a0, str0
		syscall
main:
		#This is the main program.
		#It first asks user to enter the price of each BobCat Bar.
		#It then asks user to enter the number of bar wrappers needed to exchange for a new bar.
		#It then asks user to enter how much money he/she has.
		#It then calls maxBars function to perform calculation of the maximum BobCat Bars the user will receive based on the information entered. 
		#It then prints out a statement about the maximum BobCat Bars the user will receive.
		
		addi $sp, $sp -4	# Feel free to change the increment if you need for space.
		sw $ra, 0($sp)
		# Implement your main here
		
		li $v0, 4	#takes in price and stores in $t0
		la $a0, price
		syscall
		li $v0, 5
  		syscall
  		move $t0, $v0
	
		li $v0, 4	#takes in wrap and stores in $t1
		la $a0, wrap
		syscall
		li $v0, 5
  		syscall
  		move $t1, $v0
  	
  		li $v0, 4	#takes in amount and stores in $t2
		la $a0, amount
		syscall
		li $v0, 5
  		syscall
  		move $t2, $v0
  	
  		li $v0, 4	#prints out the in progress
		la $a0, prog
		syscall
	
	

		jal maxBars 	# Call maxBars to calculate the maximum number of BobCat Bars

		# Print out final statement here

		#move $a0, $v0
		#li $v0, 1
		#syscall 
		
		#prints out "With"
		li $v0, 4	
		la $a0, final
		syscall
		
		#prints out amount
		
		move $a0, $t2
		li $v0, 1	
		syscall
		
		#prints out "you have ...."
		li $v0, 4	
		la $a0, final2
		syscall
		
		move $a0, $s1
		li $v0, 1	
		syscall
		
		#prints out "bobcat bars."
		li $v0, 4	
		la $a0, bbars
		syscall

		j end			# Jump to end of program



maxBars:
		# This function calculates the maximum number of BobCat Bars.
		# It takes in 3 arguments ($a0, $a1, $a2) as n, price, and money. It returns the maximum number of bars
		
		
		addi $sp, $sp, -8
		sw   $ra, 0($sp)#return address 
		
		div $t2, $t0
		mflo $s1
		mfhi $s2
		
		ble $s1, 1, none
		
		li $v0, 4	#prints out you first buy
		la $a0, first
		syscall
		sw $s1, 4($sp)
		
		#print out the max amount of bars possible
		move $a0, $s1
		li $v0, 1
		syscall
		
		#prints out "bars."
		li $v0, 4	
		la $a0, bars
		syscall
		
		
		
		jal newBars 	# Call a helper function to keep track of the number of bars.
		lw $s1, 4($sp)
		#adds extra to the max
		add $s1, $s1, $t3
		lw $ra, 0($sp)
		jr $ra
		# End of maxBars

none:
		jr $ra

newBars:
		# This function calculates the number of BobCat Bars a user will receive based on n.
		# It takes in 2 arguments ($a0, $a1) as number of wrappers left so far and n.
		
		#divide n by wrap
		div $s1, $t1
		mflo $s1
		mfhi $s4
		
		#checks if less than or equal to 0
		ble $s1, 0 , none
		
		#prints "you'll get another"
		la $a0, iter
		li $v0, 4
		syscall
		
		#print out "number "
		move $a0, $s1
		li $v0, 1
		syscall 
		
		#prints out "bars."
		li $v0, 4	
		la $a0, bars
		syscall
		
		add $t3, $t3, $s1
		bge $s1, $t1, newBars
		
		jr $ra
		# End of newBars

end: 		
		# Terminating the program
		lw $ra, 0($sp)
		addi $sp, $sp 4
		li $v0, 10 
		syscall
