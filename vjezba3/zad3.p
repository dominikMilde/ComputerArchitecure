                       BVJ `EQU FFFF1000 
                        
                       UVJ_D `EQU FFFF2000 
                       UVJ_B `EQU FFFF2004 
                        
                       PVJ_D `EQU FFFF3000 
                       PVJ_A `EQU FFFF3004 
                       PVJ_E `EQU FFFF3008 
                       PVJ_S `EQU FFFF300C 
                        
                       `ORG 0 
00000000  00 00 81 07          MOVE 	10000, SP 
00000004  0C 00 00 C4          JP 		GLAVNI 
                        
                       `ORG 8 
00000008  00 05 00 00  `DW 00,05,00,00 ; prekidni vektor  
                        
0000000C  10 00 10 04  GLAVNI  MOVE    %B 10000, SR 
00000010  01 00 00 04          MOVE    1, R0 
00000014  0C 30 0F B8          STORE   R0, (PVJ_S) ; omoguci da prekidna generir
00000018  04 20 0F B0  PETLJA  LOAD    R0, (UVJ_B) 
0000001C  00 00 00 6C          CMP     R0, 0 
00000020  18 00 C0 C5          JP_EQ   PETLJA 
00000024  70 05 80 B0  UCITAJ  LOAD    R1, (BROJ) 
00000028  00 20 8F B8          STORE   R1, (UVJ_D) 
0000002C  74 05 00 B0          LOAD    R0, (BROJAC) 
00000030  01 00 00 24          ADD             R0, 1, R0 
00000034  74 05 00 B8          STORE   R0, (BROJAC) 
00000038  04 20 0F B8          STORE   R0, (UVJ_B) 
0000003C  18 00 00 C4          JP      PETLJA 
                            ;prekidni vektor 
                       `ORG 500 
00000500  00 00 00 88          PUSH    R0 
00000504  00 00 80 88          PUSH    R1 
00000508  00 00 20 00          MOVE    SR, R0 
0000050C  00 00 00 88          PUSH    R0 
                              ;spremanje konteksta 
00000510  04 30 0F B8  		STORE   R0, (PVJ_A) 
00000514  00 10 0F B0  		LOAD    R0, (BVJ) 
00000518  00 00 00 6C          CMP             R0, 0 
0000051C  60 05 C0 C6          JP_SLT  ZABRANI; 
00000520  00 00 00 88  		PUSH    R0 
00000524  50 05 00 CC  		CALL    OBRADI 
00000528  04 00 F0 27  		ADD     SP, 4, SP 
0000052C  70 05 00 B8  		STORE   R0, (BROJ) 
00000530  74 05 00 B0  		LOAD    R0, (BROJAC) 
00000534  00 30 0F B8  		STORE   R0, (PVJ_D) 
00000538  08 30 0F B8  		STORE   R0, (PVJ_E) 
0000053C  00 00 00 80  		POP     R0 
00000540  00 00 10 00  		MOVE    R0, SR 
00000544  00 00 80 80  		POP     R1 
00000548  00 00 00 80          POP     R0 
0000054C  01 00 00 D8          RETI 
                        
00000550  04 00 70 B5  OBRADI  LOAD    R2, (SP+4) 
00000554  01 00 00 04          MOVE    1, R0 
00000558  00 00 04 50          SHL     R0, R2, R0 
0000055C  00 00 00 D8  VAN     RET 
                        
00000560  00 00 10 04  ZABRANI MOVE    %B 000000, SR 
00000564  00 00 00 04          MOVE    0, R0 
00000568  0C 30 0F B8          STORE   R0, (PVJ_S) 
0000056C  00 00 00 F8          HALT 
                        
00000570  00 00 00 00  BROJ `DW 00,00,00,00 
00000574  00 00 00 00  BROJAC `DW 00,00,00,00 
