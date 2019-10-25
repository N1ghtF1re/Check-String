org 100h

Start:
        mov  ah, $09       ; Выводим текст
        mov  dx,  prompt   ; Выводим приветствие
        int  21h           ;
                           ;
EntStr:                    ;
        mov  ah,   $0A     ; Ввод строки
        mov  dx, InputStr  ; Метка с адресом под имя
        int  21h           ;


Continue:
        mov  bh, 00
        mov  bl, [InputStr+1]  ; byte[InputStr+1] - длина строки
        add  bx, InputStr + 2  ; В bl уже записан размер строки. Прибавим к нему адрес начала строки
        mov  word[currSize], bx
        mov  ah, $09       ; Выводим текст
        mov  dx, Message   ;
        int  21h           ;

        mov  ah, $09       ; Выводим текст
        mov  dx, InputStr+2; InputStr - макс. длина, InputStr + 1 - текущая длина, InputStr + 2 - сама строк
        mov  byte[bx], 24h ; 24h - символ '$', помещаем его в конец строки
                           ;
        int 21h            ;

CmpSize:                   ; Подготовка и сравнение с минимумом     ;
        mov  bl, [InputStr+1]; byte[InputStr+1] - длина строки
        cmp  bl,5          ; Сравнение bl и 5
        js   badInp        ; Переход, если BL < 5

        mov bx, word[currSize]
        sub bx, 1;
        mov al, byte[bx]
        inc al
        cmp al, 48         ; Условие на то, что введена цифра  (L = 6)
        js  badInp
        cmp ah, 13
        jnz Continue
        cmp al, 58
        jns badInp         ; Если не цифра, "прыгаем" в "badInp"

        mov  cl, [InputStr+4]
        cmp  cl, [InputStr+7]
        jnz   badInp

        mov  ah, $09       ; Выводим текст
        mov  dx, goodInp   ; InputStr - макс. длина, InputStr + 1 - текущая длина, InputStr + 2 - сама строка
                           ;
        int 21h            ;
                           ;
        mov  ah, $08       ;
        int 21h            ;
        ret


InputStr db 7,9 dup(?)
currSize dw 0
Message db 13,10,"Your enter: $";
prompt db "Hello, please, enter your string",13,10,"$"
goodInp db 10,13,"Yes!$"
badInp:                   ;
        mov  ah, $09       ; Выводим текст
        mov  dx, smallStr  ;
        int  21h           ;

        mov  ah, $08       ;
        int 21h            ;
        ret                ;


smallStr db 13,10, "No!$"
