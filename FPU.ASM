;-------------------------------------------------;
;            FLOATING POINT UNIT                  ;
;-------------------------------------------------;

;MACRO DEFNITION 
DATAPOINTER:        EQU ES:[0X4500]
PROGRAMCOUNTER:     EQU ES:[0X4502]



IEEE_ADD:
    POP AX 
    POP SI 
    POP CX 
    PUSH AX 

    MOV AX,[SI]
    MOV CX,[DATAPOINTER]
    MOV 