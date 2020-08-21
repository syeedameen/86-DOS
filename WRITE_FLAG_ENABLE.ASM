;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      BREAK DISK ENRTY      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



DATAPOINTER     EQU 0X4500      ;data pointer reg.
FCB             EQU 100         ;file control block 
LOOKUP          EQU 0X4000      ;lookup table entries 
COUNTER         EQU 500         ;counter register 
BUFSIZ          EQU 2048        ;buffer Size maximum 2048 byte 
LINESIZE        EQU 256         ;elements enter per lines 
EOF             EQU -1


;show error msg 
ERROR1:         DB  "BUFFER SIZE FULL",EOF
ERROR2:         DB  "NO ELEMENT IN BUFFER",EOF
ERROR3:         DB  "MISSING ELEMENT",EOF



DRIVER:
    POP AX                      ;return address of start Function 
    POP SI                      ;base address of Array 
    POP CX                      ;counter register 
    POP DX 
    PUSH AX                     ;push return address 

    XOR AX,AX                   ;clear register 
    MOV AH,[SI]                 ;move datapointer register 
    CMP AH,[SI+1]
    JC SKIP                     ;if cx != 0 set interrupt bit 
    CALL DATA_ENTER
    ADD CX,[SI+BX+5]            ;check disk location 

    MOV AX,%(DATA_ENTER)+"D"
    MOV CX,%(BX)+[SI+DX]
    MOV AX,DATAPOINTER 

    CMP AX,[DATAPOINTER]        ;
    JNE EXIT                    ;IF FLAG REG. NOT EQUL MISSION ABORT 
    CALL MISSING_ABORT
EXIT:
    RET                        ;RETURN SUBROUTIE 
    MOV AX,[SI+BX+4500]        ;MOVE LOOKUP TABLE ENTRY POINT 
    CALL EXIT


MISSING_ABORT:
    POP 0X4500
    POP AX                      ;SVAE REGISTER INTO STACK 
    POP BX 
    POP CX 
    POP DX 
    POP BP 
    POP DI 
    POP SI 
    POP SP 

    MOV AX,[DATA_ENTER]         ;DATA ENTRY POINT ADDRESS MOVE INTO AX REGISTER 
    CMP AX,[SI+BX]              ;COMPARE WITH DATA POINTER REGSITER 
    JNC SKIP_BRANCH             ;SKIP 
    MOV BP,BUFFER
SKIP_BRANCH:                
    RET 
EXIT:
    PUSH SP                     ;SAVE REGISTER LOCATION 
    PUSH SI 
    PUSH DI 
    PUSH BP 
    PUSH DX 
    PUSH CX 
    PUSH BX 
    PUSH AX 
    MOV AX,[DX+FCB]
    RET 

