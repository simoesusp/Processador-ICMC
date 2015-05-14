" Vim syntax file
" Language: ICMC
" Maintainer:   Gabriel Rodrigues do Prado Rossales
" Last Change:  2013 Apr 11

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

setlocal iskeyword+=-
syntax case match

syntax match icmcComment /;.*/
syntax match icmcNumber /\<[-]\?\d\+\>/ " Decimal numbers
syntax region icmcString start=/"/ skip=/\\"/ end=/"/
syntax match icmcLabelColon /:/ contained
syntax match icmcLabel /\w\+:/ contains=icmcLabelColon

" Registers
syntax keyword icmcRegister r0
syntax keyword icmcRegister r1
syntax keyword icmcRegister r2
syntax keyword icmcRegister r3
syntax keyword icmcRegister r4
syntax keyword icmcRegister r5
syntax keyword icmcRegister r6
syntax keyword icmcRegister r7
syntax keyword icmcRegister fr
syntax keyword icmcRegister sp
syntax keyword icmcRegister pc

" Directives
syntax match icmcDirective "\.2byte"
syntax match icmcDirective "\.4byte"
syntax match icmcDirective "\.8byte"
syntax match icmcDirective "\.aent"
syntax match icmcDirective "\.align"
syntax match icmcDirective "\.aascii"
syntax match icmcDirective "\.asciiz"
syntax match icmcDirective "\.byte"
syntax match icmcDirective "\.comm"
syntax match icmcDirective "\.cpadd"
syntax match icmcDirective "\.cpload"
syntax match icmcDirective "\.cplocal"
syntax match icmcDirective "\.cprestore"
syntax match icmcDirective "\.cpreturn"
syntax match icmcDirective "\.cpsetup"
syntax match icmcDirective "\.data"
syntax match icmcDirective "\.double"
syntax match icmcDirective "\.dword"
syntax match icmcDirective "\.dynsym"
syntax match icmcDirective "\.end"
syntax match icmcDirective "\.endr"
syntax match icmcDirective "\.ent"
syntax match icmcDirective "\.extern"
syntax match icmcDirective "\.file"
syntax match icmcDirective "\.float"
syntax match icmcDirective "\.fmask"
syntax match icmcDirective "\.frame"
syntax match icmcDirective "\.globl"
syntax match icmcDirective "\.gpvalue"
syntax match icmcDirective "\.gpword"
syntax match icmcDirective "\.half"
syntax match icmcDirective "\.kdata"
syntax match icmcDirective "\.ktext"
syntax match icmcDirective "\.lab"
syntax match icmcDirective "\.lcomm"
syntax match icmcDirective "\.loc"
syntax match icmcDirective "\.mask"
syntax match icmcDirective "\.nada"
syntax match icmcDirective "\.nop"
syntax match icmcDirective "\.option"
syntax match icmcDirective "\.origin"
syntax match icmcDirective "\.repeat"
syntax match icmcDirective "\.rdata"
syntax match icmcDirective "\.sdata"
syntax match icmcDirective "\.section"
syntax match icmcDirective "\.set"
syntax match icmcDirective "\.size"
syntax match icmcDirective "\.space"
syntax match icmcDirective "\.struct"
syntax match icmcDirective "\.text"
syntax match icmcDirective "\.type"
syntax match icmcDirective "\.verstamp"
syntax match icmcDirective "\.weakext"
syntax match icmcDirective "\.word"

" Arithmetic and Logical Instructions
syntax keyword icmcInstruction add addc
syntax keyword icmcInstruction and
syntax keyword icmcInstruction inc
syntax keyword icmcInstruction cmp
syntax keyword icmcInstruction dec
syntax keyword icmcInstruction div divc 
syntax keyword icmcInstruction mul mulc
syntax keyword icmcInstruction mod
syntax keyword icmcInstruction not
syntax keyword icmcInstruction or
syntax keyword icmcInstruction shiftl0 shiftl1 
syntax keyword icmcInstruction shiftr0 shiftr1
syntax keyword icmcInstruction rotl 
syntax keyword icmcInstruction rotr
syntax keyword icmcInstruction sub subc
syntax keyword icmcInstruction xor

" In and Out Instructions
syntax keyword icmcInstruction inchar
syntax keyword icmcInstruction outchar

" Stack Instructions
syntax keyword icmcInstruction push
syntax keyword icmcInstruction pop

" Procedure Calls
syntax keyword icmcInstruction call
syntax keyword icmcInstruction ceq
syntax keyword icmcInstruction cne
syntax keyword icmcInstruction cz
syntax keyword icmcInstruction cnz
syntax keyword icmcInstruction cc
syntax keyword icmcInstruction cnc
syntax keyword icmcInstruction cgr
syntax keyword icmcInstruction cle
syntax keyword icmcInstruction ceg
syntax keyword icmcInstruction cel
syntax keyword icmcInstruction cov
syntax keyword icmcInstruction cno
syntax keyword icmcInstruction cn
syntax keyword icmcInstruction cdz
syntax keyword icmcInstruction rts

" Jump Instructions
syntax keyword icmcInstruction jmp 
syntax keyword icmcInstruction jeq
syntax keyword icmcInstruction jne
syntax keyword icmcInstruction jz
syntax keyword icmcInstruction jnz
syntax keyword icmcInstruction jc
syntax keyword icmcInstruction jnc
syntax keyword icmcInstruction jgr
syntax keyword icmcInstruction jle
syntax keyword icmcInstruction jeg
syntax keyword icmcInstruction jel
syntax keyword icmcInstruction jov
syntax keyword icmcInstruction jno
syntax keyword icmcInstruction jn
syntax keyword icmcInstruction jdz

" Memory Access Instructions
syntax keyword icmcInstruction store
syntax keyword icmcInstruction load
syntax keyword icmcInstruction storei
syntax keyword icmcInstruction loadi

" Data Movement Instructions
syntax keyword icmcInstruction mov
syntax keyword icmcInstruction loadn

" Exception and Interrupt Instructions
syntax keyword icmcInstruction clearc
syntax keyword icmcInstruction setc
syntax keyword icmcInstruction halt
syntax keyword icmcInstruction breakp
syntax keyword icmcInstruction nop

hi def link icmcComment        Comment
hi def link icmcNumber         Number
hi def link icmcString         String
hi def link icmcLabel          Label
hi def link icmcRegister       Identifier
hi def link icmcDirective      Type
hi def link icmcInstruction    Statement

hi Comment ctermfg=darkgrey
hi Label ctermfg=darkblue
hi Identifier ctermfg=green
hi Statement ctermfg=yellow

let b:current_syntax = "icmc"
