.386
.model flat, stdcall
option casemap :none

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

; include \masm32\include\windows.inc
; include \masm32\include\kernel32.inc
; include \masm32\include\masm32.inc
; includelib \masm32\lib\kernel32.lib
; includelib \masm32\lib\masm32.lib

ExitProcess PROTO, dwExitCode:DWORD
MessageBoxA PROTO, hWnd:DWORD, lpText:PTR BYTE, lpCaption:PTR BYTE, uType:DWORD
StdOut PROTO, dwPrintFormat:DWORD, lpText:PTR BYTE, lpTextLen:DWORD

.data
    prompt db "Enter a decimal number: ", 0
    result db "The corresponding hex number is: ", 0

.code
    ReadDec PROC
        pushad                 ; 保存所有通用寄存器的值

        xor ebx, ebx           ; 清零 EBX (用于记录读取的数值)
        xor ecx, ecx           ; 清零 ECX (用于记录字符计数)

        readLoop:
            mov ah, 01h        ; 使用功能号1来读取字符
            int 21h            ; 调用DOS的21h中断

            cmp al, 0Dh        ; 检查是否为回车键
            je exitLoop

            sub al, '0'        ; 字符转换为数字
        
            mov edx, 10        ; 乘以10
            imul ebx, edx

            add ebx, eax       ; 乘法的结果加上新的数字

            inc ecx            ; 增加计数器

            jmp readLoop

        exitLoop:
            mov eax, ebx       ; 将结果保存在 EAX 中

        popad                  ; 恢复寄存器的值
        ret
    ReadDec ENDP

    Crlf PROC
        push edx       ; 保存寄存器的值
        push eax
    
        mov dl, 0Dh    ; 输出回车符
        mov ah, 02h    ; 使用功能号2来输出字符
        int 21h        ; 调用DOS的21h中断

        mov dl, 0Ah    ; 输出换行符
        int 21h

        pop eax        ; 恢复寄存器的值
        pop edx
        ret
    Crlf ENDP

    ; StdOut PROC
    ;     pushad                ; 保存通用寄存器的值

    ;     mov eax, 1            ; 将文件句柄设置为标准输出
    ;     mov ebx, 1

    ;     mov ecx, esi          ; 将要输出的字符串地址存储在 ECX 中
    ;     mov edx, esi          ; 将字符串长度存储在 EDX 中
    ;     mov dl, [esi-1]       ; 获取字符串长度（不包括结尾的空字符）
    ;     add dl, 1

    ;     mov ah, 40h           ; 使用功能号40h来进行写文件操作
    ;     int 21h               ; 调用DOS的21h中断

    ;     popad                 ; 恢复寄存器的值
    ;     ret
    ; StdOut ENDP


    main PROC
        ; 获取十进制数
        mov edx, OFFSET prompt
        call StdOut

        xor eax, eax
        mov edi, 10
        call ReadDec

        ; 转换为十六进制
        mov ecx, 8
        mov edi, OFFSET result
        add edi, 28        ; 将结果存储在数组的倒数第一个位置
    convertLoop:
        xor edx, edx
        div ecx           ; 除法，得到商和余数
        add dl, '0'       ; 将余数转换为字符形式

        cmp dl, '9'       ; 检查余数是否大于9
        jle @F
        add dl, 7         ; 转换为A-F的字符
    @@:
        dec edi           ; 将字符存储在结果数组中
        mov BYTE PTR [edi], dl

        test eax, eax     ; 检查商是否为零
        jnz convertLoop

        ; 输出结果
        mov edx, OFFSET result
        call StdOut

        mov eax, edi
        mov esi, OFFSET result
        sub eax, esi
        call StdOut

        call Crlf

        ; 退出程序
        xor eax, eax
        call ExitProcess
    main ENDP
END main
