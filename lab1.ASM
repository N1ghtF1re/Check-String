org 100h

Start:
        mov  ah, $09       ; ������� �����
        mov  dx,  prompt   ; ������� �����������
        int  21h           ;
                           ;
EntStr:                    ;
        mov  ah,   $0A     ; ���� ������
        mov  dx, InputStr  ; ����� � ������� ��� ���
        int  21h           ;


Continue:
        mov  bh, 00
        mov  bl, [InputStr+1]  ; byte[InputStr+1] - ����� ������
        add  bx, InputStr + 2  ; � bl ��� ������� ������ ������. �������� � ���� ����� ������ ������
        mov  word[currSize], bx
        mov  ah, $09       ; ������� �����
        mov  dx, Message   ;
        int  21h           ;

        mov  ah, $09       ; ������� �����
        mov  dx, InputStr+2; InputStr - ����. �����, InputStr + 1 - ������� �����, InputStr + 2 - ���� ������
        mov  byte[bx], 24h ; 24h - ������ '$', �������� ��� � ����� ������
                           ;
        int 21h            ;

CmpSize:                   ; ���������� � ��������� � ���������     ;
        mov  bl, [InputStr+1]; byte[InputStr+1] - ����� ������
        cmp  bl,5          ; ��������� bl � 5
        js   badInp        ; �������, ���� BL < 5

        mov bx, word[currSize]
        sub bx, 1;
        mov al, byte[bx]
        cmp al, 48         ; ������� �� ��, ��� ������� �����  (L = 6)
        js  badInp
        cmp al, 58
        jns badInp         ; ���� �� �����, "�������" � "badInp"

        mov  cl, [InputStr+4]
        cmp  cl, [InputStr+7]
        jnz   badInp

        mov  ah, $09       ; ������� �����
        mov  dx, goodInp   ; InputStr - ����. �����, InputStr + 1 - ������� �����, InputStr + 2 - ���� ������
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
        mov  ah, $09       ; ������� �����
        mov  dx, smallStr  ;
        int  21h           ;

        mov  ah, $08       ;
        int 21h            ;
        ret                ;


smallStr db 13,10, "No!$"