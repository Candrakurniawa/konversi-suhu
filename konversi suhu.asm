                 DATA SEGMENT 
    T DB ?
    RES DB 10 DUP ('$')
    MSG1 DB "MASUKAN CELCIUS(2 DIGIT): $"
    MSG2 DB 10,13, "DIKONVERSIKAN FAHRENHET: $"
    
DATA ENDS

CODE SEGMENT
    ASSUME DS:DAT.DS:CODE
STAR:
     MOV AX,DATA
     MOV DS,AX
     
     LEA DX,MSG1
     MOV AH,9
     INT 21H  
     
     MOV AH,1
     INT 21H
     
     SUB AL,30H
     MOV AH,0                              
     
     
     MOV BL,10
     MUL BL
     MOV BL,AL
     
     MOV AH,1
     INT 21H
     
     SUB AL,30H
     MOV AH,0
     ADD AL,BL
     MOV T, AL
     
     MOV DL,9
     MUL DL 
     
     MOV BL,5
     DIV BL
     MOV AH,0
     
     ADD AL,32
     
     LEA SI, RES
     CALL HEX2DEC
     
     LEA DX,MSG2
     MOV AH,9
     INT 21H
     
     LEA DX, RES
     MOV AH,9
     INT 21H
     
     MOV AH,4CH
     INT 21H
     
CODE ENDS

HEX2DEC PROC NEAR
     MOV CX, 0
     MOV BX, 10
     
 LOOP1: MOV DX, 0
     DIV BX
     ADD DL, 30H
     PUSH DX
     INC CX
     CMP AX, 9
     JG LOOP1
     
     ADD AL, 30H
     MOV [SI], AL
 LOOP2: POP AX
     INC SI
     MOV [SI], AL
     LOOP LOOP2
     RET
HEX2DEC ENDP

END STAR   
     
    