;     nasm -felf64 Primos.asm && gcc -no-pie Primos.o && ./a.out

        global  main
        extern  printf
        extern scanf

        section .text
main:
        push    RBX 

        mov 	RDI, Cadena
        call 	printf 

        mov 	RDI, FormatoScanf
        mov 	RSI, Numero        
        call 	scanf

        mov     RCX, [Numero]
        jmp 	obtenerRaiz

    primos:
    		mov 	RBP,[Raiz]
    		mov 	AX,[Numero]
    		xor 	CX,CX
    		xor 	DX,DX
    		mov 	CX,2
    		jmp 	ciclo

    	ciclo: 	
    			mov 	AX,[Numero]
	    		div  	CX
	    		cmp 	DX,0
	    		je 		posible
	        	inc 	CX
	        	xor 	RDX,RDX
	    		jmp 	ciclo

	    posible:
			mov 	AX,[Numero]
			xor 	RDX,RDX
			cmp 	CX,AX
			je 		siPrimo
			inc 	CX
			cmp 	RCX,RBP
			jge 	noPrimo
			jmp 	ciclo

		siPrimo:
			mov 	RDI, SiEsPrimo
       	 	call 	printf 
       	 	pop     RBX                     
		    ret

		noPrimo:
			mov 	RDI, NoEsPrimo
       	 	call 	printf 
       	 	pop     RBX                     
		    ret
    	

    obtenerRaiz:
			xor     RAX, RAX                
		    xor     RBX, RBX  
		    xor 	RBP, RBP              
		    inc     RBX
		    mov 	RAX, RBX
		    jmp 	bucle                     

		bucle:                 
		        mul     RBX 
		        cmp 	RAX,RCX
		        je 		exacta
		        jg  	noExacta
		        inc     RBX                              
		        mov		RAX,RBX
		        jmp 	bucle

		exacta:
				mov 	[Raiz],RBX
				jmp 	primos

		noExacta:
				mov 	RBP,RAX
				dec 	RBX
				mov 	RAX,RBX
				mul 	RBX

				mov 	[Raiz],RBX
				jmp 	primos

        section .data
Cadena:
		db "Ingrese un Numero: ", 0
FormatoScanf:
		db  "%d", 0
NoEsPrimo:
		db 	"No es Primo",10,0
SiEsPrimo:
		db 	"Si es Primo",10,0
		section .bss
Numero:
		resw 1
Raiz:
		resd 1