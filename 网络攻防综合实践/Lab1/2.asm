.386
.model flat, stdcall
option casemap :none

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
    src BYTE “Hello World”, 0Dh, 0Ah, 0
    dst BYTE SIZEOF src DUP(0), 0
.code
    MOV ECX, SIZEOF src
    MOV ESI, 0
L1:
    MOV AL, BYTE PTR src[ESI]
    MOV BYTE PTR dst[ESI], AL
    INC ESI
    LOOP L1

    
