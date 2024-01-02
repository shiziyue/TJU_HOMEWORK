.386
.model flat, stdcall
option casemap :none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
    str_prompt BYTE "Please input a decimal number(0~4294967295):", 0
    str_result BYTE "the hexdecimal number is:", 0
    decbuf BYTE 20 DUP(0)
    dbuf DWORD ?
    abuf BYTE "0000000000", 0

.code
dec2dw PROC
    pushad                ; 保存通用寄存器的值
    ; mov ecx, SIZEOF decbuf
    mov esi, 0
    mov eax, 0
    parseDigits:
        xor edx, edx
        mov dl, BYTE PTR decbuf[esi]
        cmp dl, 0
        je finish
        sub dl, 48D        ; 将 ASCII 码转换为数字
        imul eax, 10D       ; 将 eax 倍增以为新的部分
        add eax, edx       ; 将当前数字添加到 eax 的末尾
        inc esi             ; 增加索引以继续处理下一个数字
        LOOP parseDigits
    finish:
        mov dbuf, eax      ; 存储结果到 dbuf
        ; invoke StdOut,eax
        popad              ; 恢复寄存器的值
        ret
dec2dw ENDP

dw2ascii PROC
    mov edi, OFFSET abuf
    mov ecx, 10
    mov eax, dbuf ; edx 的初始值
    mov ebx, 16D ; 除数
    convert:
        xor edx, edx ; 清零 edx 寄存器
        div ebx ; 将 eax 除以 ebx，结果保存在 eax 中，余数保存在 edx 中
        cmp edx, 9d
        ja add7
        back:
        add dl, '0' ; 将余数转换为 ASCII 
        mov [edi+ecx], dl ; 存储 ASCII 到目标位置
        dec ecx ; 增加目标索引
        test eax, eax ; 检查是否达到结束条件
        jnz convert
    ret
    add7:
        add dl, 7d
        jmp back
dw2ascii ENDP



main PROC
    invoke StdOut, addr str_prompt
    invoke StdIn, addr decbuf, 20
    ;转换为16进制
    call dec2dw
    call dw2ascii
    invoke StdOut, addr str_result
    invoke StdOut, addr abuf
    invoke ExitProcess, 0
main ENDP
END main


