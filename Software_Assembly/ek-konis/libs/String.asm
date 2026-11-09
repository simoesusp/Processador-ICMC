jmp main

;#Include Control.asm

;START OF LIB
; ---------- Basic String Library
;
;   Basic Implemenntaion Of a FString. Curently supports Decimal numbers and Hex Numbers.
;
;   Dec Will not work with the vlue zero, but i dont want to fix that rn
;
;   To make FString experince better we would have to eddit the Assembler.
;


;Private
    DigitHexFinder: ; <r3 = Num> , <r3 = Char> Takes a number from 0 to 15 and gives back the coresponding hex char
		push r4
		
		loadn r4, #10
		cmp r3, r4	   ; Checks if shift is nedded for char
		jle DigitHexFinder_SkipShift
		loadn r4, #7
		add r3, r3, r4  ; goes from 9 to A

		DigitHexFinder_SkipShift:
		loadn r4, #"0"
		add r3, r3, r4  ; add num to the char for 0, with the proper handling of 7,8,9 -> A,B,C 
		pop r4
		rts


    ;ResolveStringSpecialChar Data
        StringSpecialCharNum: var #1  ; this is important to stop many bugs. 
            ; CSpecial Chars Start at 256 and go up sequencialy. Just define a function to handle them. 
            static StringSpecialCharNum + #0 , #3

        StringSpecialCharHandlers: var #3
            static StringSpecialCharHandlers + #0 , #ResolveString_Hex
            static StringSpecialCharHandlers + #1 , #ResolveString_Dec
            static StringSpecialCharHandlers + #2 , #ResolveString_Str

    ResolveStringSpecialChar:  ; assumes r5 = 255

        push r4
        push r5
        push r6
        push r7

        sub r4, r4, r5   ; gets a shift that must be added to #StringSpecialCharNum

        load r6, StringSpecialCharNum
        cmp r4, r6
        jgr ResolveStringSpecialChar_Exit

        loadn r5, #StringSpecialCharNum
        add r5, r5, r4

        loadi r7, r5
        call CallI

        ResolveStringSpecialChar_Exit:
        pop r7
        pop r6
        pop r5
        pop r4
        rts

    ; if all Resolve String functions start looking the same, i can just make a single resolve string that callsI on the Print...OnScreen Functions
    ResolveString_Hex:
        inc r1
        push r1
        loadi r1, r1 ; gets value in string
        loadi r1, r1 ; gets valkue pointed by the ptr 

        call PrintHexNumberOnScreen

        dec r0 ; fix the off by one in the str printing

        pop r1
        rts 

    ResolveString_Dec:
        inc r1
        push r1
        loadi r1, r1 ; gets value in string
        loadi r1, r1 ; gets valkue pointed by the ptr 

        call PrintDecNumOnScreen

        dec r0 ; fix the off by one in the str printing

        pop r1
        rts 
    ResolveString_Str:
        inc r1
        push r1
        push r2


        inc r1
        loadi r2, r1
        dec r1

        loadi r1, r1 ; gets value in string

        call PrintFStr

        dec r0 ; fix the off by one in the str printing

        pop r2
        pop r1
        rts 


; Public
    PrintHexNumberOnScreen: ; <Index, Number>, <New Screen Index>   ; Prints On Screen

			push r2
			push r3

			; r0 is the Index to print the number
			loadn r3, #"x"
			outchar r3, r0
			inc r0

			loadn r2, #61440  ; Highest Four Bits
			and r3, r1, r2 
			shiftR0 r3, #12
			call DigitHexFinder
			outchar r3, r0
			inc r0

			loadn r2, #3840  ; High middle Four Bits
			and r3, r1, r2 
			shiftR0 r3, #8
			call DigitHexFinder
			outchar r3, r0
			inc r0

			loadn r2, #240  ; Low middle Four Bits
			and r3, r1, r2 
			shiftR0 r3, #4
			call DigitHexFinder
			outchar r3, r0
			inc r0

			loadn r2, #15  ; Low Four Bits
			and r3, r1, r2 
			call DigitHexFinder
			outchar r3, r0
			inc r0

			pop r3
			pop r2

			rts
        
    
    PrintDecNumOnScreen_Buffer: var #6
        static  PrintDecNumOnScreen_Buffer + #5, #10 ; sentinel
    PrintDecNumOnScreen:   ; <Index, Number> , <New Screen Index> ; Prints On Screen

        push r1
        push r2
        push r3
        push r4
        push r5

        PrintDecNumOnScreen_ZeroCheck:
            loadn r3, #0
            cmp r1, r3
            jeq PrintDecNumOnScreen_PrintZero

        loadn r2, #PrintDecNumOnScreen_Buffer
        loadn r3, #4
        add r2, r2, r3
        loadn r3, #0
        loadn r4, #10
        PrintDecNumOnScreen_DivWhileR1GreaterThanZero:
            div r5, r1, r4 ; r5 is the number without the remainder
            mul r5, r5, r4 ; r5 is the number with the highest digits
            sub r5, r1, r5 ; r5 is the remainder, in this case the least significant digit
            storei r2, r5
            dec r2
            div r1, r1, r4
            cmp r1, r3
            jgr PrintDecNumOnScreen_DivWhileR1GreaterThanZero

        loadn r4, #"0"
        loadn r5, #9
        PrintDecNumOnScreen_WalkBuffer:
            inc r2
            loadi r3, r2
            cmp r3, r5 
            jgr PrintDecNumOnScreen_Exit
            add r3, r3, r4
            outchar r3, r0
            inc r0
            jmp PrintDecNumOnScreen_WalkBuffer
            
        ; print zero if the number is zero

        PrintDecNumOnScreen_PrintZero:
            loadn r3, #"0"
            outchar r3, r0
            inc r0

        PrintDecNumOnScreen_Exit:
        pop r5
        pop r4
        pop r3
        pop r2
        pop r1
        rts

    PrintStr:  ; <Printing Pos, Str*, color>, < > 
        push r1	 ; String Address ; its now a pointer
        push r2	 ; color
        push r3
        push r4
        
        loadn r3, #'\0'

        PrintStr_Loop:
            loadi r4, r1          ; Carrega no r4 o caractere apontado por r1
            cmp r4, r3            ; Compara o caractere atual com '\0'
            jeq PrintStr_Exit    ; Se for igual a '\0', salta para ImprimeStr_Exit, encerrando a impressão.
            
            add r4, r2, r4        ; Soma r2 ao valor do caractere. 
            
            outchar r4, r0         ; Imprime o caractere (r4) na posição de tela (r0).
            inc r0                 ; Incrementa a posição na tela para o próximo caractere.
            inc r1                 ; Incrementa o ponteiro da string para o próximo caractere.
            jmp PrintStr_Loop    ; Volta ao início do loop para continuar imprimindo.

        PrintStr_Exit:	
        pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
        pop r3
        pop r2
        pop r1
        rts

    PrintFStr: ; <Printing Pos, Str*, color>, < Last Printed Pos> a little slower than normal printing

            ; 256 = Hex Num
            ; 257 = Dec Num

        ;    r0  ; printing position
        push r1	 ; String Address ; its now a pointer
        push r2	 ; color
        push r3
        push r4
        push r5
        
        loadn r3, #'\0'

        loadn r5, #255

        PrintFStr_Loop:
            loadi r4, r1          ; Carrega no r4 o caractere apontado por r1
            cmp r4, r3            ; Compara o caractere atual com '\0'
            jeq PrintFStr_Exit    ; Se for igual a '\0', salta para ImprimeStr_Exit, encerrando a impressão.

            cmp r4, r5  
            jgr PrintFStr_SpecialCharHandler
                
            ; normal Print 
                add r4, r2, r4        ; Soma r2 ao valor do caractere.
                outchar r4, r0         ; Imprime o caractere (r4) na posição de tela (r0).
            
            jmp PrintFStr_SkipResolveStringSpecialChar
                PrintFStr_SpecialCharHandler:
                    call ResolveStringSpecialChar
                PrintFStr_SkipResolveStringSpecialChar:
            
            inc r0                 ; Incrementa a posição na tela para o próximo caractere.
            inc r1                 ; Incrementa o ponteiro da string para o próximo caractere.
            jmp PrintFStr_Loop    ; Volta ao início do loop para continuar imprimindo.

        PrintFStr_Exit:	
        pop r5
        pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
        pop r3
        pop r2
        pop r1
        rts


;END OF LIB


; TESTS
main:
    ; Test 1

        ; DATA
        TestHex1 : var #1
            static TestHex1 + #0 , #8246 
        TestStr1 : string "Isso e um numero HEX: 00 Texto Depois do Numero"
            static TestStr1 + #22, #256  ; Hex Marker
            static TestStr1 + #23, #TestHex1  ; Hex num addr
        ; Test
        loadn r0, #10
        loadn r1, #TestStr1
        loadn r2, #0

        call PrintFStr

    ; Test 2
        ; DATA
        TestDec1 : var #1
            static TestDec1 + #0 , #8246 
        TestStr2 : string "Isso e um numero DEC: 00 Texto Depois do Numero"
            static TestStr2 + #22, #257  ; DEC Marker
            static TestStr2 + #23, #TestDec1  ; Hex num addr
        ; Test
        loadn r0, #120
        loadn r1, #TestStr2
        loadn r2, #0

        call PrintFStr

        ; Test 3
        ; DATA
        TestInnerString1 : string "Inner_String"
        TestStr3 : string "Isso e uma string: 000 Texto Depois do Numero"
            static TestStr3 + #19, #258  ; DEC Marker
            static TestStr3 + #20, #TestInnerString1  ; Hex num addr
            static TestStr3 + #21, #64512   ; color blue
        ; Test
        loadn r0, #240
        loadn r1, #TestStr3
        loadn r2, #0

        call PrintFStr


        ; Test 4
        ; DATA
        ;TestInnerString1 : string "Inner_String"
        TestStr4 : string "Isso e uma string Recursiva: 000 Texto Depois do Numero"
            static TestStr4 + #28, #258  ; Str Marker
            static TestStr4 + #29, #TestStr4  ; Str addr
            static TestStr4 + #30, #0
        ; Test
        loadn r0, #360
        loadn r1, #TestStr4
        loadn r2, #0

        call PrintFStr

    halt


        

