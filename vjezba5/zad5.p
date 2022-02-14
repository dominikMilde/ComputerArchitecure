00000000  81 D4 A0 E3  GLAVNI		MOV		R13, #81<8 
00000004  01 04 A0 E3  			MOV 	R0, #1<8 					;pointer na ulaz 
00000008  04 14 A0 E3  			MOV		R1, #4<8					;pointer na izlaz 
                       			 
0000000C  04 20 90 E4  PETLJA		LDR		R2, [R0], #4 
00000010  08 0E 52 E3  			CMP		R2, #8<28 					;usporedi sa zakljucnim podatkom 
00000014  2E 00 00 0A  			BEQ		KRAJ 
00000018  00 00 52 E3  			CMP		R2, #0 
0000001C  04 20 81 04  			STREQ	R2, [R1], #4 
00000020  FB FF FF 0A  			BEQ		PETLJA 
00000024  02 30 A0 E1  			MOV 	R3, R2		 
00000028  04 00 2D E9  			STMFD	R13!, {R2}					;stavi na stog 
0000002C  0A 00 00 EB  POZIV1		BL		KUB							;rezultat vraca u R2 
00000030  04 D0 8D E2  			ADD		R13, R13, #4				;micem sa stoga 
00000034  01 20 42 E2  			SUB		R2, R2, #1 					;u R2 mi je sada lijevi argument 
00000038  02 40 A0 E3  			MOV 	R4, #2 
0000003C  93 04 03 E0  			MUL		R3, R3, R4					;u R3 mi je sada desni argument 
00000040  0C 00 2D E9  			STMFD	R13!, {R2, R3} 				;argumenti na stog 
00000044  0E 00 00 EB  POZIV2		BL		DIV 
00000048  08 D0 8D E2  			ADD 	R13, R13, #8 
                       			;rezz vracen u R3 
0000004C  04 30 81 E4  SPREMI		STR		R3, [R1], #4 
00000050  EF FF FF EA  			B		PETLJA 
                       			 
                       			 
00000054  03 00 2D E9  KUB			STMFD	R13!, {R0, R1}				;spremanje kont. 
                       			;ADD		R10, R13, #8 
00000058  08 D0 8D E2  			ADD		R13, R13, #8 
0000005C  01 00 9D E8  			LDMFD	R13, {R0} ;R10 
00000060  00 10 A0 E1  			MOV		R1, R0 
00000064  90 01 00 E0  			MUL		R0, R0, R1 
00000068  90 01 00 E0  			MUL		R0, R0, R1 
0000006C  00 20 A0 E1  			MOV		R2, R0 
00000070  08 D0 4D E2  			SUB 	R13, R13, #8				; u R2 vracam rezz 
00000074  03 00 BD E8  			LDMFD	R13!, {R0, R1}				;vracanje kont.. 
00000078  0E F0 A0 E1  			MOV		PC, LR  					; povratak u glavni 
                       	 
                       			 
0000007C  76 00 2D E9  DIV			STMFD	R13!, {R1, R2, R4, R5, R6}	; spremanje kontek
                       			;ADD 	R10, R13, #14				;koliko treba 
00000080  14 D0 8D E2  			ADD		R13, R13, #14 
00000084  06 00 9D E8  			LDMFD	R13, {R1, R2} ;R10 
00000088  08 4E A0 E3  			MOV		R4, #8<28					;maska 
0000008C  00 50 A0 E3  			MOV		R5, #0						; brojac negativnih 
00000090  01 10 91 E1  			ORRS	R1,	R1, R1 
00000094  01 50 85 42  			ADDMI	R5, R5, #1 
00000098  00 10 61 42  			RSBMI	R1, R1, #0					; ako je negativan, komplementira
0000009C  02 20 92 E1  			ORRS	R2, R2, R2 
000000A0  01 50 85 42  			ADDMI	R5, R5, #1 
000000A4  00 20 62 42  			RSBMI	R2, R2, #0					; ako je neg, komp 
000000A8  00 30 A0 E3  			MOV		R3, #0; 	counter odnosno REZZ  
000000AC  02 10 51 E0  LOOP_DIV	SUBS	R1, R1, R2 
000000B0  01 30 83 52  			ADDPL	R3, R3, #1 
000000B4  FE FF FF 5A  			BPL		LOOP_DIV 
                       			 
000000B8  01 00 55 E3  			CMP		R5, #1 
000000BC  00 30 63 02  			RSBEQ	R3, R3, #0 ;neka je negativan 
000000C0  14 D0 4D E2  			SUB		R13, R13, #14 
000000C4  76 00 BD E8  			LDMFD	R13!, {R1, R2, R4, R5, R6} 
000000C8  0E F0 A0 E1  			MOV 	PC, LR 						;skok u glavni 
                        
000000CC  56 34 12 EF  KRAJ		SWI 	123456 
                        
                       `ORG 100 
00000100  00 00 00 00  `DW 00,00,00,00,03,00,00,00,06,00,00,00,FF,FF,FF,FF,FA,FF
          03 00 00 00  
          06 00 00 00  
          FF FF FF FF  
          FA FF FF FF  
          00 00 00 80  
