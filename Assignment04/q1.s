			AREA q_one, CODE, READONLY
			ENTRY
			
;-----------Main Program----------------
			ADR sp, stack				; put address of the stack in the stack pointer sp	
			LDR r0, x					; load the value of x into r0			
			LDR r1, n					; load the value of n into r1			
			BL power					; call the power function		
done		B	done					; endless loop to finish

;-----------Power Function--------------
power		STMFD sp!, {fp, lr}
			ADD fp, sp, #4
			SUB sp, sp, #16
			STR r0, [fp, #-16]
			STR r1, [fp, #-20]
		;---Base Case n==0 ----
			ldr     r3, [fp, #-20]
			cmp     r3, #0			
			moveq     r3, #1
			beq	return       
		;---Case n==1 ---------
			ldr     r3, [fp, #-20]
			cmp     r3, #1
			bne     case3
			ldr     r3, [fp, #-20]
			sub     r3, r3, #1
			mov     r1, r3
			ldr     r0, [fp, #-16]
			bl      power
			mov     r2, r0
			ldr     r3, [fp, #-16]
			mul     r3, r2, r3
			b       return
		;---Case n>1 ----------
case3		ldr     r3, [fp, #-20]
			sub     r3, r3, #1
			mov     r1, r3
			ldr     r0, [fp, #-16]
			bl      power
			mov     r3, r0
			str     r3, [fp, #-8]
			ldr     r3, [fp, #-16]
			ldr     r2, [fp, #-8]
			mul     r3, r2, r3
		;-----------------------
return		mov     r0, r3
			sub     sp, fp, #4
			ldmfd   sp!, {fp, lr}
			bx      lr
;---------------------------------------

;-----------Data Area-------------------
			AREA q_one, DATA, READWRITE
			SPACE 0xFF					; space allocated for stack				
stack		DCD 0x0000					; stack
n			DCD 3						; the value of the exponent (n) to be applied to x
x 			DCD 2						; the value of x to be powered
			END