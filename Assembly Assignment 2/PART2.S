.text
.global			_start
									
_start: 
				LDR 	R1,=0xFF200000 		// LEDR port
				LDR 	R4,=0xFF200050 		// KEY
				LDR 	R8,=0xFFFEC600 		// clock
				LDR 	R0,=50000000 		// timer of clock

				STR 	R0,[R8] 			// write to load register
				MOV 	R0,#0b011 			// E=1, A=1 “Activate”
				STR 	R0, [R8,#8] 		// write to control register
				MOV 	R5,#0b0000000001 	// initial pattern 
				
MAIN:			B		LOOPL


				
CHECK:			STR 	R5,[R1] 			// write to LEDR 
				LDR 	R7,[R4]				// read KEY
				CMP		R7, #0
				BEQ		NO_KEY
				
WAIT1:			LDR 	R7,[R4] 			// read KEY
				CMP 	R7,#0
				BEQ		WAIT2
				B		WAIT1				// LOOP UNTIL NO_KEY
				
WAIT2:			LDR 	R7,[R4] 			// read KEY
				CMP 	R7,#0
				BNE		WAIT3
				B		WAIT2				// LOOP UNTIL NO_KEY			
				
WAIT3:			LDR 	R7,[R4] 			// read KEY
				CMP 	R7,#0
				BEQ		NO_KEY
				B		WAIT3				// LOOP UNTIL NO_KEY

				
NO_KEY:			MOV		PC, LR
				
										
LOOPL:			CMP 	R5, #0b1000000000
				BEQ		LOOPR
				
				LSL 	R5,#1
				BL 		DELAY
				BL		CHECK
				B 		LOOPL
		
		
LOOPR:			CMP 	R5, #0b0000000001
				BEQ		LOOPL
				
				LSR 	R5,#1
				BL 		DELAY
				BL		CHECK
				B 		LOOPR				
			
			
DELAY: 			LDR 	R0, [R8,#0xC]  		// read timer 
				CMP 	R0,#0
				BEQ 	DELAY				// wait for F==1
				STR 	R0,[R8,#0xC] 		// reset F to zero
				MOV		PC,LR
.end
