			AREA q_one, CODE, READONLY
			ENTRY
;-----------Main Program------------------------			
			ADR r1, String1	- 1					; load the address of the start of string 1 in r1
			ADR r0, EoS1 - 1					; load the end of string 1 in r0
			SUB r4, r0, r1						; find the length of string 1 put it in r4
			ADR r2, String2						; load the address of the start of string 2 in r2
			ADR r10, EoS2						; load the end of string 2 in r10
			SUB r10, r10, r2					; find the length of string 2 put it in r10
			ADR r3, String3	 					; load the address of the start of string 3 in r2												
			ADD r7, r3, r4						; move r7 starting point ahead by the length of string 1
			LDRB r5, [r1]						; load first character of string 1 into r5
			LDRB r6, [r2]						; load first character of string 2 into r6
			CMP r4, r10							; compare the two string lengths.
			MOVLT r4, r10						; if string 2 is bigger, set that length to r4, otherwise leave as is
			MOV r9, #0							; set counter to 0

;----start of loop------------------------------			
loop		CMP r1,r0 							; compare current point in string 1 to the end of string 1
			LDRNEB r5, [r1, #1]!				; gets the current char from string 1, and increments s1 if not at end
			STRNEB r5, [r3, #1]!				; stores string 1 letter in string 3, then increments if not at end
			CMP r6, #0							; compare current point in string 2 to the null character
			LDRNEB r6, [r2], #1					; gets the current char from string 2, and increments s2 if not at end
			STRNEB r6, [r7, #1]!				; stores string 2 letter in string 3, then increments if not at end
			ADD r9, r9, #1						; add one to the counter
			CMP r9, r4							; compare counter with length of longest string
			BNE loop							; if not equal branch back to loop
done		B	done							; done loop

;-----------Data Area---------------------------
			AREA q_one, DATA, READWRITE
String1		DCB "This is a test string1"		; String 1
EoS1		DCB 0x00							; end of string 1
String2		DCB "This is a test string2"		; String 2
EoS2		DCB 0x00							; end of string 2
String3		SPACE 0xFF							; space assigned for string 3
			END