			AREA q_one, CODE, READONLY
			ENTRY
			
;-----------Main Program----------------
			ADR sp, stack				; put address of the stack in the stack pointer sp	
			LDR a2, n					; load the value of n into r0
			LDR a3, x					; load the value of x into r1			
			BL power					; call the power function		
done		B	done					; endless loop to finish

;-----------Power Function--------------
power		STMFD sp!, {v1, v2, lr}
			MOV v1, a2					; save n
			MOV v2, a3					; save x
		;---Base Case n==0 ----
			CMP a2, #0					; check if n is 0
			MOVEQ a1, #1				; return 1			
			BEQ return					; returns if equal
		;---Case n==1 ---------
			CMP a2, #1					; check if n is 1
			SUBEQ a2, a2, #1			; subtract 1 from 
			BLEQ power					; if it is equal call power again
			BNE case3					; branch to final case
			MUL a1, a3, a1				; multiply returned value by x
			B return					; go to return
		;---Case n>1 ----------
case3		SUB a2, a2, #1				; subtract 1 from n			
			BL power					; recursively call again					
			MUL a1, a3, a1
return		LDMFD sp!, {v1, v2, lr}
			BX lr
;---------------------------------------

;-----------Data Area-------------------
			AREA q_one, DATA, READWRITE
			SPACE 0xFF					; space allocated for stack				
stack		DCD 0x0000					; stack
n			DCD 2						; the value of the exponent (n) to be applied to x
x 			DCD 2						; the value of x to be powered
			END