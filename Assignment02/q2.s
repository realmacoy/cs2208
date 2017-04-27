		AREA q_two, CODE, READONLY
		ENTRY
		ADR r0, STRING -1					; start of string into r0
		ADR r1, EoS							; end of string in r1
fwd		CMP r0, r1							; check if the checks have passed eachother
		BGT pass							; if r0 > r1, then they have passed each other and branch to the pass label
		LDRB r2, [r0,#1]!					; Load start of string character into r2, and increment
		CMP r2, #65							; Check if it is less than capital letter
		BLT fwd								; if it is less than zero, get next character
bwd		LDRB r3, [r1,#-1]!					; Load end of string character into r3 and decrement
		CMP r3, #65							; Check if it is less than capital letter
		BLT bwd								; If it less than zero, get next character
		CMP r2, #97						    ; check if letter is lowercase
		ADDLT r2, #32						; if it is uppercase, change it to lowercase
		CMP r3, #97						    ; check if letter is lowercase
		ADDLT r3, #32						; if it is uppercase, change it to lowercase
		CMP r2, r3							; compare the two characters.
		MOV r4, #1							; add a valid code into r4, later to go into r0
		BEQ fwd								; if they are the same, go to next character
		MOV r4, #2							; add an invalid code into r4, later to go into r0
pass	CMP r4, #0							; compares valid code with 0
		MOVNE r0, r4						; if the compare is not 0, then use existing valid code
		MOVEQ r0, #2						; if compare is 0, then set code to not valid
loop	B loop
		
		AREA q_two, DATA, READWRITE
STRING	DCB "He lived as a devil, eh?"		; String
EoS		DCB 0x00							; End of string
		END