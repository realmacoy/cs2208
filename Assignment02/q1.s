		AREA q_one, CODE, READONLY
		ENTRY		
		ADR r0, UPC - 1			; load address of UPC in r0
		MOV r4, #6				; a counter from 6 down
lp		LDRB r1, [r0, #1]!		; get value at r0 and put in r1
		SUB r1, r1, #48			; subtract the ascii number to get decimal
		SUBS r4, r4, #1 		; decrement the counter
		ADD r2, r2, r1			; add to a running total for first sum
		LDRB r1, [r0, #1]!		; get value at r0 and put in r1		
		SUB r1, r1, #48			; subtract the ascii number to get decimal for first sum
		BEQ out					; checks if we are at the end, then it skips the check digit				
		ADD r3, r3, r1			; add to a running total for first sum		
		BNE	 lp					; checks if the counter is zero
out		ADD r2, r2, LSL #1		; multiply first sum by 3
		ADD r2, r2, r3			; adds sum 1 and sum 2 saves in r2
		SUB r2, r2, #1			; subtracts 1 from sum of first and second sums
div		SUB r2, r2, #10			; repeated subtract by 10 (div)
		CMP r2, #10				; compares the subtraction with 10
		BGT	div					; if it is > 10, loop again
		SUB r2, r2, #9			; subtract 9 from remainder
		ADDS r2, r1				; add check digit and remainder
		MOV r0, #1				; valid		
		BEQ done				; if it equals 0, then skip to end, else not valid
		MOV r0, #2				; not valid		
done	B done
		
		AREA q_one, DATA, READWRITE
UPC		DCB "013800150738" 	; UPC code as a string
		END