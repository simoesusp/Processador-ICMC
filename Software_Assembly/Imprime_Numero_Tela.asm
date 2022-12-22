jmp main

main:
  push r0
  push r1
  
    loadn r0, #578 ; posicao de impressao
    loadn r1, #65535 ; numero a ser impresso (no caso max de 16 bits)
    call Imprime_Numero
  pop r1
  pop r0
  halt
  rts


Imprime_Numero:
  ; recebe a posicao do primeiro digito no r0
  ; recebe o numero a ser impresso no r1
  push r4 ; posicao tela
  push r5
  push r6
  push r7 ; Score atual
    mov r4, r0 ; move a posicao inicail
    loadn r5, #4 
    add r4, r4, r5 ; soma 4 pois serao impressos 5 digitos de tras pra frente
    mov r7, r1 ; move o numero a ser impresso, pois ele sera modificado
    Loop_Imprime_Numero:
      loadn r6, #10 ; div e mod por 10   
      mod r5, r7, r6
      div r7, r7, r6 ; divide score por 10
      loadn r6, #48 ; ascii 0
      add r5, r5, r6 ; soma resto no ascii zero
      outchar r5, r4
      dec r4 ; decrementa posicao
      loadn r6, #0
      cmp r7, r6 ; ve se nao eh zero
      jne Loop_Imprime_Numero
      loadn r5, #1
      mov r6, r0 ; move posicao inicial
      sub r6, r6, r5 ; subitrai 1 para criterio de aprada
    Loop_Imprime_Zero_Numero: ; completa com zero
      cmp r4, r6
      jeq Sair_Imprime_Numero ; se forem iguais sai
      loadn r5, #48 ; ascii 0
      outchar r5, r4
      dec r4 ; decrementa posicao
      jmp Loop_Imprime_Zero_Numero

  Sair_Imprime_Numero:   
    pop r7
    pop r6
    pop r5
    pop r4
    rts

  