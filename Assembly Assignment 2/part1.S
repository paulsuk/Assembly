// R0 is our "counter" for the FOR loop
// R9 is our "swapped" variable, lets us know if a FOR loop (inner loop) had switched a value
// R1, R2 will be our i, i+1 (addresses for list items)
// R3, R4 will temporarily hold the contents at R1, R2 to make the comparison

			.text
			.global _start

_start:		
			LDR 	R0, List			//load R0 with the first element of List aka the number of list items
			MOV		R9, #0				//R9 is the "swapped" flag
			SUB		R0, #1

MAIN:		LDR		R1, =List			// IS THERE A BETTER WAY TO DO THIS?????
			LDR		R2, =List
			ADD 	R1, #4				//R1 holds the current list item
			ADD		R2, #8				//R2 holds the next list item
			MOV		R6, R1
			MOV		R7, R2
			B 		OUTLOOP	
	
	
OUTLOOP:	MOV 	R9, #0
			BL		INLOOP
			
			CMP		R9, #0
			BEQ		END
			LDR 	R0, List
			SUB		R0, #1 	
			
			B 		OUTLOOP

			
INLOOP:		CMP		R0, #0
			BEQ		ENDLOOP				//if List[i] > List[i+1], do not swap
	
			LDR		R3, [R1]
			LDR		R4, [R2]
			MOV		R10,LR
			BL 		SWAP
			
			ADD		R1, #4
			ADD		R2, #4	
			SUB		R0, #1
			MOV 	LR, R10
			B		INLOOP
			
	
ENDLOOP:	MOV		R1, R6
			MOV		R2, R7
			
			MOV		PC, LR

			
END:		B 		END


SWAP:		CMP		R4, R3
			BLT		NOSWAP
			
			MOV 	R9, #1				//set "swapped" flag to 1
			EOR		R3, R3, R4			//swap R1 and R2
			EOR		R4, R3, R4
			EOR		R3, R3, R4
			STR		R3, [R1]
			STR		R4, [R2]
			MOV		PC, LR
			
NOSWAP:		MOV 	PC, LR
			
List: .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33	

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			