                       `ORG 0 
00000000  81 D4 A0 E3  			MOV		R13, #81<8   						;spranca za omogucavanje preki
00000004  00 70 0F E1  			MRS		R7, CPSR 
00000008  80 70 C7 E3  			BIC		R7, R7, #80 
0000000C  07 F0 21 E1  			MSR		CPSR_c, R7 
00000010  2F 00 00 EA  			B		MAIN						 
                       			 
                       			;prekidni potprogram na adr 18 
                       `ORG 18 
00000018  59 40 2D E9  INTERR		STMFD 	R13!, {R0, R3, R4, R6, R14}			;spremi kont
0000001C  08 10 81 E5  			STR		R1, [R1, #8]						;brisanje BS-a 
00000020  00 00 00 E2  			AND		R0, R0, #0								;resetiraj brojac 
00000024  0C 00 81 E5  			STR		R0, [R1, #0C] 
00000028  0D 00 A0 E3  			MOV 	R0, #0D		 
0000002C  1D 00 00 EB  			BL		LCDWR						;D je brisanje unutra 
00000030  02 60 A0 E3  			MOV		R6, #2							;counter 
00000034  3E 00 A0 E3  			MOV		R0, #3E	 
                       										;znak <							 
00000038  1A 00 00 EB  PRINT_ST	BL		LCDWR 
0000003C  01 60 56 E2  			SUBS	R6, R6, #1 
00000040  FE FF FF CA  			BGT		PRINT_ST 
00000044  17 00 00 EB  			BL		LCDWR 
00000048  A8 30 9F E5  SKOK		LDR		R3,	INDEX 
0000004C  04 34 83 E2  			ADD		R3, R3, #4<8						;INDEX + 400 je adresa 
00000050  00 00 D3 E5  			LDRB	R0, [R3]							;u R2 je kod 
00000054  00 40 A0 E1  			MOV		R4, R0								; kopiraj u R4 
00000058  00 00 50 E3  			CMP 	R0, #0 
0000005C  94 00 8F 05  			STREQ	R0, INDEX 
00000060  FA FF FF 0A  			BEQ		SKOK 
                       			 
00000064  0F 00 00 EB  			BL		LCDWR 
                        
00000068  03 60 A0 E3  ZNAK_VEC	MOV		R6, #3								;counter 
0000006C  3C 00 A0 E3  			MOV		R0, #3C								;znak > 
                       			 
00000070  0C 00 00 EB  PRINT_ND	BL		LCDWR 
00000074  01 60 56 E2  			SUBS 	R6, R6, #1 
00000078  FE FF FF CA  			BGT		PRINT_ND 
                       			 
0000007C  0A 00 A0 E3  			MOV		R0, #0A								;ispisi na ekran 
00000080  08 00 00 EB  			BL		LCDWR 
                       			 
00000084  04 34 43 E2  			SUB		R3, R3, #4<8 
00000088  00 00 54 E3  			CMP		R4, #0 
0000008C  00 30 03 02  			ANDEQ	R3, R3, #0								;skoci na pocetak 
00000090  01 30 83 12  ZNAK_MAN	ADDNE	R3, R3, #1							;nastavi 
00000094  5C 30 8F E5  			STR		R3, INDEX 
                       			 
00000098  59 40 BD E8  			LDMFD	R13!, {R0, R3, R4, R6, R14} 
                       			 
0000009C  04 F0 5E E2  KRAJ_PR		SUBS	PC, LR, #4 
                        
000000A0  01 00 2D E9  LCDWR		STMFD	R13!, {R0} 
000000A4  00 00 50 E3  			CMP		R0, #0 
000000A8  07 00 00 0A  			BEQ		PREP 
                       			 
000000AC  7F 00 00 E2  			AND		R0, R0, #7F						;ASCII je 7 bitni, b[7] = 0 
000000B0  04 00 C2 E5  			STRB 	R0, [R2, #4]					 
                       			 
000000B4  80 00 80 E3  			ORR		R0, R0, #80						;postavi bit[7] na jedan 
000000B8  04 00 C2 E5  			STRB	R0, [R2, #4]					 
                       			 
000000BC  80 00 00 E2  			AND		R0, R0, #80						;postavi na nulu 
000000C0  04 00 C2 E5  			STRB	R0, [R2, #4] 
000000C4  01 00 BD E8  PREP		LDMFD	R13!, {R0} 
000000C8  0E F0 A0 E1  OUT			MOV		PC, LR 
                        
000000CC  1C 10 9F E5  MAIN		LDR		R1, RTC_ADR						;R1 je pointer na RTC 
000000D0  1C 20 9F E5  			LDR		R2, GPIO_ADR					;R2 je pointer na UI jed. 
000000D4  01 00 A0 E3  			MOV		R0, #1							 
000000D8  10 00 81 E5  			STR		R0, [R1, #10]					;omoguci post. interrupta 
000000DC  01 04 A0 E3  			MOV		R0, #1<8						;postavi 256 na RTC 
000000E0  04 00 81 E5  			STR		R0, [R1, #4]					;		-||- 
000000E4  00 00 00 EA  LOOP		B 		LOOP 
                        
                        
000000E8  00 FE FF FF  RTC_ADR `DW 00,FE,FF,FF 
000000EC  00 FF FF FF  GPIO_ADR `DW 00,FF,FF,FF 
000000F0  00 00 00 00  INDEX `DW 00,00,00,00 
                        
                       `ORG 400 
00000400  49 6E 74 65  `DW 49,6E,74,65,72,6E,61,74,69,6F,6E,61,6C,69,73,61,74,69
          72 6E 61 74  
          69 6F 6E 61  
          6C 69 73 61  
          74 69 6F 6E  
          00           
