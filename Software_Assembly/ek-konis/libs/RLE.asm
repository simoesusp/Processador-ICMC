loadn r0, #65534
push r0    ; stop stack overflow in StackTrace of the error handler
jmp Tests

;#Include ErrorHandler.asm
;#Include String.asm

;START OF LIB
;-------------- RLE Library V0.1
;
;	RLE Stands for Run Lenght Enocding. It is a simple compression method that is incredibly simple, but very efective at
;	some kinds of repetitive sequential data. Strings like "00000000100000111111111" which would take 23 words in memory, would take [8,"0",1,"1",5,"0",9,"1"], which   
;	is just 8 words. More than 50% compression. It works by storing a count and a object pair, for each element it finds. But if repeated and sequential elements are found,
;	it only needs to increment the count, which does not use more memory. 
;
	;Private

	;Public
	; Fully Working
	RLEDecoder:   ; <*target, *source>, <> ; Decodes the data in r1 to the memory that starts in r0
		push r0
		push r1
		push r2
		push r3
		push r4
		; r0 is the string it will decode to. Pointer
		; r1 is the string it will decode from. Pointer
		
		loadn r3, #'\0'

		RLEDecoder_Loop:
			loadi r4, r1          ; Carrega no r4 o caractere apontado por r1
			cmp r4, r3            ; Compara o caractere atual com '\0'
			jeq RLEDecoder_Exit   ; Se for igual a '\0', salta para ImprimeStr_Sai, encerrando a impressão.
			

			mov r2, r4 ; loop lengh
			inc r1
			loadi r4, r1	; looped character
			inc r2 ; makes loop easier, no need to compare to zero
				CharacterDecode_Loop:
				dec r2
				jz CharacterDecode_Exit
				
					storei r0, r4
					inc r0	

					jmp CharacterDecode_Loop

				CharacterDecode_Exit:
				inc r1 
			jmp RLEDecoder_Loop    ; Volta ao início do loop para continuar imprimindo.

		RLEDecoder_Exit:	
		pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
		pop r3
		pop r2
		pop r1
		pop r0
		rts



	RLEEncoder: ; <*target, *source, size> | < r2 = SizeOfCompressedData >    ; Encodes data from source to target.; Be carefull, output data here does not have a preditable output lenght 

		push r0
		push r1
		; r2 is output
		push r3
		push r4
		push r5
		push r6
		push r7

		loadn r7, #0

		mov r3, r2
		loadn r2, #0   ; char counter
		loadi r4, r1   ; preivous char
		loadn r6, #0   ; permanent counter

		RLEEncoder_loop:

			cmp r3, r6 ; size / chars read
			jel RLEEncoder_exit

			loadi r5, r1 ; char in source

			cmp r5, r4  ; compare current char with prev char
			jeq RLEEncoder_CharEqual
				; not equal
				storei r0, r2  ; store counter
				inc r0
				inc r7
				storei r0, r4 ; store previous char
				inc r0 ; *count of new char
				inc r7
				mov r4, r5   ; new char being counted
				loadn r2,  #0; re-start count

			RLEEncoder_CharEqual:  
				inc r2 ; count of char
				inc r1 ; *source
				inc r6 ; permanent counter
				
		jmp RLEEncoder_loop
		
		RLEEncoder_exit:

			storei r0, r2  ; store counter
			inc r0
			inc r7
			storei r0, r4 ; store previous char
			inc r0
			inc r7
			push r7
			loadn r7, #0
			storei r0, r7 ; count of 0 = terminator
			pop r7
			inc r7
			mov r2, r7

		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		; r2 = Size Of Data
		pop r1
		pop r0

		rts

	RLETraverser: ; <Target Index, RLEstring*, Buffer*> , <r3 = Value>

			push r0
			push r1
			push r2
			push r4
			push r5
			push r6

			; What does the buffer coitain. A index in the RLE string and A Target index. What it tells us is 
			; adding up all counts up to where we are in the RLE String is the Target Index Stored. As such we can know 
			; somewhat where we are in the uncompressed RLE string. This speeds up massively reads that are sequential in nature without having to decompress data.
			; And with less overhead.

			; Compared with a full decode, there is no need to the decode the string, and it uses less memory
			; Compared With a Sequential read of the RLE, it speeds up reading things that are close to each other. 

			; Buffer Layout  {Index where the fragment starts, Shift to the count of that fragment itself}
			; so if: Buffered Index <= target < Buffered Index + RLE[Buffered shift], we know that the data is in this fragment,
			; so we inc the RLE pointer, deference it output it. 
			; Then we buffer this place again. 

			; IF Buffered Index + RLE[Buffered shift] <= target
			; we inc the pointer 2 times and reepeat what we had done the top again with the new values.

			; IF target < Buffered Index, we need to go backwards.

			; get buffered data
		 	loadi r3, r2 ; Buffered Target Index
			inc r2
			loadi r4, r2 ; Buffered RLE index
			add r4, r1, r4 ; gets beffered position in RLE
			dec r2

			cmp r0, r3  ; the target index is ___ than the buffered target index 

			jeq RLETraverser_CasheHit

			jle RLETraverser_Backwards   ; If target < Buffer we jump to the backwards loop 
			
				; code execute in the foward pass
				
				RLETraverser_FowardsLoop:
				loadi r5, r4  ; gets count of current fragment 
				add r3, r3, r5  ; finds the start of next frag and buffers it
				cmp r0, r3  ; is target index < startof next frag (buffered r3)
							; if yes, exit the loop
							; else continue
				jle RLETraverser_Exit
				inc r4
				inc r4
				jmp RLETraverser_FowardsLoop
			
			RLETraverser_Backwards:   ; We will reach here if the data is inside the current cashed reagion or prior to it. 

				dec r4
				dec r4

				loadi r5, r4  ; gets count of prev fragment 
				sub r3, r3, r5  ; finds the start of prev frag and buffers it
				cmp r0, r3  ; is target index >= startof prev frag (buffered r3)
							; if yes, exit the loop
							; else continue
				jeg RLETraverser_CasheHit   ; jump greater or equal, we do now want to sub r5 again
				jmp RLETraverser_Backwards



			RLETraverser_Exit:
			sub r3, r3, r5
			RLETraverser_CasheHit:
			storei r2, r3  ; store start of next frag
			inc r2

			sub r1, r4, r1  ; get rle index to be buffered
			storei r2, r1

			inc r4
			loadi r3, r4 ; get value at correct target
						; and place it at r3 (exit register)

			pop r6
			pop r5
			pop r4
			pop r2
			pop r1
			pop r0
			rts


	; Not Implemented Yet
	RLEPartialDecoder: ; <Target*, Source*, target start index, Length>, < >   ; Could be buffered or not, i'm not sure which is better for now

		; Takes A RLEstring and decodes from a start index. Can be used to decode a part of interest faster. Could be edited in many ways to suit your code better. 
		; You might perfer to pass a index in the RLE instad of the expedcted decoded string, or whathver else you can cook up.

		rts 

	RLERectangleDecoder: ; <Target*, Source*, Width>
		;Takes a width and decodes in a special way. Supose you have a list 1200 addresses long, it represents the screen or something paralel to it. 
		; You have data that is shaped like a rectangle that is smaller than the screen, now you can save 2 words per unit of height in the encoded data,
		; and probably take less time decoding (Depends on the size, this one takes slightly longer per index)

		rts
;END OF LIB

; ----- Tests: DO NOT COPY FROM HERE ON
;
;	 DO NOT COPY DO NOT COPY DO NOT COPY
;

		; Test DATA     ; DATA is arranged like this to make it easier to visualy comapre the memeory to verify results
			DecodeTarget: var #100 
			TestData1: var #11     ; Rle Compression of 100 long string
				static TestData1 + #0, #20 ; first count
				static TestData1 + #1, #"A"
				static TestData1 + #2, #10
				static TestData1 + #3, #"B"
				static TestData1 + #4, #10
				static TestData1 + #5, #"D"
				static TestData1 + #6, #30
				static TestData1 + #7, #"E"
				static TestData1 + #8, #30
				static TestData1 + #9, #"F"
				static TestData1 + #10, #0
			EncodeTarget: var #100  ; we dont know how big the encoded data will be

			TestTraverseBuffer: var #2
				static TestTraverseBuffer + #0, #0
				static TestTraverseBuffer + #1, #0

			TestReturn: var #2
				static TestReturn + #1, #0



		Tests:
			; Test 1 Encode / Decode
				loadn r0, #DecodeTarget
				loadn r1, #TestData1
				call RLEDecoder

				loadn r0, #EncodeTarget
				loadn r1, #DecodeTarget
				loadn r2, #100
				call RLEEncoder


				loadn r0, #EncodeTarget
				loadn r1, #TestData1
				loadn r2, #11
				call MemCompare
				mov r1, r0
				loadn r0, #1
				call CheckIfOne

			; Test2 Traversal


				loadn r0, #0
				loadn r1, #TestData1
				loadn r2, #TestTraverseBuffer
				loadn r4, #"A"  ; 0-19

				call RLETraverser
				store TestReturn, r3
				cmp r3, r4
				jeq Skip_Test2Error1
					loadn r0, #2
					call CallFatalError
					Skip_Test2Error1:

				loadn r0, #20
				loadn r4, #"B"  ; 20 - 29
				call RLETraverser
				store TestReturn, r3
				cmp r3, r4
				jeq Skip_Test2Error2
					loadn r0, #3
					call CallFatalError
					Skip_Test2Error2:

				loadn r0, #21
				loadn r4, #"B" ; 20 - 29
				call RLETraverser
				store TestReturn, r3
				cmp r3, r4
				jeq Skip_Test2Error3
					loadn r0, #4
					call CallFatalError
					Skip_Test2Error3:

				loadn r0, #39
				loadn r4, #"D" ; 30 - 39
				call RLETraverser
				store TestReturn, r3
				cmp r3, r4
				jeq Skip_Test2Error4
					loadn r0, #4
					call CallFatalError
					Skip_Test2Error4:

				loadn r0, #10
				loadn r4, #"A" ; 
				call RLETraverser
				store TestReturn, r3
				cmp r3, r4
				jeq Skip_Test2Error5
					loadn r0, #5
					call CallFatalError
					Skip_Test2Error5:


				loadn r0, #99  
				loadn r4, #"F"
				call RLETraverser
				store TestReturn, r3
				cmp r3, r4
				jeq Skip_Test2Error6
					loadn r0, #6
					call CallFatalError
					Skip_Test2Error6:


			; all tests Passed
			loadn r0, #100
			call CallFatalError


; ##### Dependedncies For Tests

;----------- Error Messages
;
;
	; Error Mesages
	; 
	; Simply declare a String and add it to the Error MessageTable. The value in the + #num will be the Error ID.
	; 
		TestError : string "This is a Error Mesage, PC that called the error: "
		EncodeDecodeError1: string "Test 1 failed"
		TraverseError1 : string "Traverse Failed Test 1    Buffer: 00 , 00     Returned: 00"
			static TraverseError1 + #34, #257
			static TraverseError1 + #35, #TestTraverseBuffer
			static TraverseError1 + #39, #257
			static TraverseError1 + #40, TestTraverseBuffer + #1
			static TraverseError1 + #55, #258
			static TraverseError1 + #56, #TestReturn
		TraverseError2 : string "Traverse Failed Test 2    Buffer: 00 , 00     Returned: 00"
			static TraverseError2 + #34, #257
			static TraverseError2 + #35, #TestTraverseBuffer
			static TraverseError2 + #39, #257
			static TraverseError2 + #40, TestTraverseBuffer + #1
			static TraverseError2 + #55, #258
			static TraverseError2 + #56, #TestReturn
		TraverseError3 : string "Traverse Failed Test 3    Buffer: 00 , 00     Returned: 00"
			static TraverseError3 + #34, #257
			static TraverseError3 + #35, #TestTraverseBuffer
			static TraverseError3 + #39, #257
			static TraverseError3 + #40, TestTraverseBuffer + #1
			static TraverseError3 + #55, #258
			static TraverseError3 + #56, #TestReturn
		TraverseError4 : string "Traverse Failed Test 4    Buffer: 00 , 00     Returned: 00"
			static TraverseError4 + #34, #257
			static TraverseError4 + #35, #TestTraverseBuffer
			static TraverseError4 + #39, #257
			static TraverseError4 + #40, TestTraverseBuffer + #1
			static TraverseError4 + #55, #258
			static TraverseError4 + #56, #TestReturn
		TraverseError5 : string "Traverse Failed Test 5    Buffer: 00 , 00     Returned: 00     String Location: 00"
			static TraverseError5 + #34, #257
			static TraverseError5 + #35, #TestTraverseBuffer
			static TraverseError5 + #39, #257
			static TraverseError5 + #40, TestTraverseBuffer + #1
			static TraverseError5 + #56, #257
			static TraverseError5 + #57, #TestReturn
			static TraverseError5 + #81, #256
			static TraverseError5 + #82, #TestData1

		AllTestsPassed : string "All Tests Passed, Nice!"


		ErrorMessageTable: var #256

			static ErrorMessageTable + #0, #TestError
			static ErrorMessageTable + #1, #EncodeDecodeError1
			static ErrorMessageTable + #2, #TraverseError1
			static ErrorMessageTable + #3, #TraverseError2
			static ErrorMessageTable + #4, #TraverseError3
			static ErrorMessageTable + #5, #TraverseError4
			static ErrorMessageTable + #6, #TraverseError5		
			static ErrorMessageTable + #100, #AllTestsPassed
