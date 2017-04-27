			AREA q_two, CODE, READONLY
			ENTRY
;-----------Main Program------------------------
			ADR r1, String1							; load the address of the start of string 1 in r1
			ADR r2, String2							; load the address of the start of string 2 in r2				
			MOV r3, #'t'							; put the value of t in r3
			LDR r4, =0x746865						; save the word the in a register for comparison
;-----------Loop--------------------------------	
loop		LDRB r6, [r1], #1						; load the current character of string 1 into r6 and increment
			CMP r6, r3								; check if it is the letter t
			STRNEB r6, [r2], #1						; if it is not t, then store it in string 2 and increment
			BLEQ func1								; if it is equal, branch to the function  func1
			CMP r6, #0								; check if it is the end of a string
			BNE loop								; if it is not, then loop
done 		B	done								; endless loop

;-----------Function----------------------------
func1		MOV r10, r1								; copy address of string location from r1 to r10
			LDRB r7, [r10, #-2]!					; load the previous letter of the string in r7 and increment r10
			CMP r7, #0x20							; check if it is a space
			CMPNE r7, #0							; or a null character
			BNE out									; if it is not either, go to the end of the function
			MOV r9, #3								; loop counter set to 3
			MOV r8, #0								; this register will have the next three letters added to it for compare.
innerLoop	LDRB r7, [r10, #1]!						; load next character into r7 and increment
			ADD r8, r7, r8, LSL #8					; add character in r7 into r8 and shift it by 8 left, (1 bytes)
			SUBS r9, r9, #1							; subtract one from counter, and set flags
			BNE innerLoop							; if not 0, go back to innerLoop
			CMP r8, r4								; compare word in r8, with the word the stored in r4
			BNE out									; if they are not equal, go to end of function
			LDRB r7, [r10, #1]!						; load next character in r7 and increment r10
			CMP r7, #0x20							; check if it is a space
			CMPNE r7, #0							; or a null character
			MOVEQ r1, r10							; if it is one of the above two, then set address in r1 equal to address in r10 (skip word)
out			STRNEB r3, [r2], #1						; if not equal, store the letter t in string 2
			BX r14									; exit out of the function and return to address in r14
;-----------------------------------------------
			
;-----------Data Area---------------------------
			AREA q_two, DATA, READWRITE
BOS			DCB 0x00									; beginning of string 1
String1		DCB "the The and the1 took thee breathe"	; String 1
EoS			DCB 0x00									; end of string 1
String2		SPACE 0xFF									; space assigned for string 3
			END