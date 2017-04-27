			AREA q_three, CODE, READONLY
			ENTRY
;-----------Main Program------------------------
			MOV r0, #3							; load an initial value into r0
			MOV r1, #0							; start with 0 in r1
			ADR r2, storage						; put the address for the start of the storage area in r2
			BL calc								; call the function calc
			ADD r1, r0, LSL #1					; multiply r0 by 2 and save it in r1			
done		B done								; endless loop

;-----------Function----------------------------
calc		STMFD r2!, {r3-r9}  				; store the values in r3-r9 into memory			
			LDR r3, a							; put the value of a in r3
			LDR r4, b							; put the value of b in r4
			LDR r5, c							; put the value of c in r5
			LDR r6, d							; put the value of d in r6
			MUL r8, r0, r0						; square x and put it in r8
			MUL r8, r3, r8						; multiply a and x squared, put in r8
			MLA r0, r4, r0, r8					; multiply x(r0) and b, and add to running total save it in r0
			ADD r0, r0, r5						; add c to running total, save in r0
			CMP r0, r6							; compare running total with d value
			MOVGT r0, r6						; if value is greater than d, set running total to d
			LDMFD r2!, {r3-r9}					; load the value from memory back into r3-r9
			BX r14								; leave the function, back to where it was called. (r14)
;-----------------------------------------------

;-----------Data Area---------------------------
			AREA q_three, DATA, READWRITE
a			DCD 5
b			DCD 6
c			DCD 7
d			DCD 50
			SPACE 64
storage		DCD 0x00				
			END