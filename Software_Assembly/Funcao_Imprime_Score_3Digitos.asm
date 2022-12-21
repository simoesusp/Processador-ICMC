;Autores: Augusto Lescura Pinto - Felipe Tanus Rodrigues - Pablo Felipe Montemor
;https://github.com/Gutelinha/funcao-score
;centena
loadn r1, #582  		; Posição para imprimir os pontos
load r0, Point 	                ; r0 = Point
loadn r2, #100 			; r2 = 100
div r3, r0, r2 			; r3 = r0 / r2    ->   pega o dígito da centena
loadn r4, #48 			; r4 = 48
add r3, r3, r4 			; r3 += r4  ->  converssao para ascii (numero -> ascii)
outchar r3, r1 			; print a centena
sub r3, r3, r4 			; r3 -= r2  ->  ascii -> numero
mul r3, r3, r2 			; r3 *= r2  ->  multiplica o dígita da centena por 100
sub r0, r0, r3 			; r0 -= r3  ->  remove as centenas

; DEZENA
inc r1
loadn r2, #10
div r3, r0, r2
loadn r4, #48
add r3, r3, r4
outchar r3, r1
sub r3, r3, r4
mul r3, r3, r2
sub r0, r0, r3

;
inc r1
add r0, r0, r4
outchar r0, r1
