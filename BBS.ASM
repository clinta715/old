; credz for dis code go to apex/lithium, patch/flt for xample c0dez.
; by Natas / LiTHiUM...

.model tiny
.286
.code
        org 100h

start:
        cli;
        Mov Al,0ffh                             ; Mask off all unneccesary interrupts. 0x7a 1
        Out 21h,Al                              ; mask ints 2

        mov ax, 0b800h
        mov ds, ax
        mov si, 0
        push cs
        pop es
        mov di, offset buf
        mov cx, 2000
        repnz movsw

        mov dx, offset buf
        call splitout

        call hidecursor

        mov dx, offset ansi
        call splitin

        call rasterbars

        mov dx, offset ansi
        call splitout

        mov dx, offset buf
        call splitin

        xor al, al;  // enable ints 1
        out 21h, al;  // enable ints 2
        sti;

        call showcursor

    jmp exit

;void _fastcall presetrowscan(char s)
;{
;        char tmp;
;
;        outportb(0x3d4, 8);
;        tmp=inp(0x3d5);
;        outportb(0x3d5, (tmp & 0xE0) | (s & 0x0F));
;}

prerowscan PROC
        ; ax = s
        push ax
        push bx
        push dx

        push ax
        mov dx, 03d4h   ;
        mov al, 8       ;
        out dx, al      ;
        inc dx          ; dx = 0x3d5
        in al, dx       ; bl = tmp

        mov bl, al
        pop ax          ; now work with s
        and bl, 0e0h
        and al, 00fh
        or al, bl
        out dx, al

        pop dx
        pop bx
        pop ax
        ret
prerowscan ENDP


;void _fastcall setscanstart(int i)
;{
;        vsync_end();
;        startoff((i / 16)*80);
;        vsync_start();
;        presetrowscan(i);
;}

setscanstart PROC
        push ax
        push bx
        push dx
        ; ax = i
        call vsyncend

        shr ax, 4

        mov bx, 80
        mul bx

        call startoff

        call vsyncstart

        call prerowscan

        pop dx
        pop bx
        pop ax
        ret
setscanstart ENDP


;void _fastcall setsplitscan(int s)
;{
;   unsigned int i;
;
;   if(wh) i=s; else i=(2*25*16-s);
;   setscanstart(i);
;   if(wh==1) wh=0; else wh=1;
;}

setsplit PROC
        ; ax = s, bx = i
        push ax
        push bx
        push dx

        cmp wh, 1
        je i_is_s
        mov wh, 1
        mov bx, 2*25*16
        sub bx, ax
        jmp ss_main
i_is_s:
        mov bx, ax
        mov wh, 0
ss_main:
        mov ax, bx
        call setscanstart

        pop dx
        pop bx
        pop ax
        ret
setsplit ENDP



;void _fastcall splitout(char *buf)
;{
;        register int i;
;        int x;
;
;        init_split();
;        movedata(FP_SEG(buf), FP_OFF(buf), 0xb800,4000,4000);
;        for(x=0;x<4000;x++) pokeb(0xb800,x,0);
;        for(x=8000;x<12000;x++) pokeb(0xb800,x,0);
;        for(i=nposs;i>0;i--) setsplitscan(poss[i]);
;
;        movedata(FP_SEG(buf), FP_OFF(buf), 0xb800,0,4000);
;        startoff(0); prerow(0);
;        for(x=4000;x<8000;x++) pokeb(0xb800,x,0);
;}

splitout PROC
        ; buf = cs:dx, ax = i, bx = x, only dx is passed...

        push cs ; ] move cs -> ds
        pop ds  ; ]
        mov si, dx      ; offset of thingy to put on screen
        mov ax, 0b800h  ; ]
        mov es, ax      ; ] move to 0xb800, 4000
        mov di, 4000    ; ]
        mov cx, 2000    ; ] 2000 words = 4000 bytes
        repnz movsw

        mov ax, 0b800h ; ]
        mov es, ax     ; ]
        xor ax, ax     ; ]
        xor di, di     ; ] clear da screen at offset 0
        mov cx, 2000   ; ]
        repnz stosw    ; ]

        mov ax, 0b800h ; ]
        mov es, ax     ; ]
        xor ax, ax     ; ]
        mov di, 8000   ; ] clear da screen at offset 8000
        mov cx, 2000   ; ]
        repnz stosw    ; ]

        mov di, 20
        mov cx, nposs

splitout_main:
        mov al, poss[di]
        inc di
        mov ah, poss[di]
        call setsplit
        inc di

        dec cx
        cmp cx, 10
        jne splitout_main

        push cs
        pop ds
        mov si, dx       ; offset of thingy to put on screen
        mov ax, 0b800h   ; ]
        mov es, ax       ; ] move to 0xb800, 0
        mov di, 0        ; ]
        mov cx, 2000     ; ] 2000 words = 4000 bytes
        repnz movsw

        xor ax, ax
        call startoff
        call prerow

        ret
splitout ENDP


;void _fastcall startoff(int offsetus)
;{
;    _BX = offsetus;
;
;    asm mov al,0xc;
;    asm mov ah, bh;
;    asm mov dx, 0x3d4;
;    asm out dx, ax
;    asm mov al,0xd;
;    asm mov ah,bl;
;    asm out dx, ax;
;}

startoff PROC
        ; ax = offset
        push ax
        push bx
        push dx

        mov bx, ax
        mov al, 0ch
        mov ah, bh
        mov dx, 03d4h
        out dx, ax
        mov al, 0dh
        mov ah, bl
        out dx, ax

        pop dx
        pop bx
        pop ax
        ret
startoff ENDP

vsyncstart PROC
        push ax
        push dx

        mov dx,03dah;
l1:
        in al,dx;
        test al,8;
        jz l1;

        pop dx
        pop ax
        ret
vsyncstart ENDP

vsyncend PROC
        push ax
        push dx

        mov dx,03dah;
l2:
        in al,dx;
        test al,8;
        jnz l2;

        pop dx
        pop ax
        ret
vsyncend ENDP


;void _fastcall splitin(char *buf)
;{
;        int i, x;
;
;        init_split();
;        movedata(FP_SEG(buf), FP_OFF(buf), 0xb800,4000,4000);
;        startoff(2000);
;        for(x=0;x<4000;x++) pokeb(0xb800,x,0);
;        for(x=8000;x<12000;x++) pokeb(0xb800,x,0);
;
;        for(i=1;i<nposs;i++) setsplitscan(poss[i]);
;}

splitin PROC
        ; ax=i, bx=x, buf=moveoff
        push cs ; ] move cs -> ds
        pop ds  ; ]
        mov si, dx      ; offset of thingy to put on screen
        mov ax, 0b800h  ; ]
        mov es, ax      ; ] move to 0xb800, 4000
        mov di, 4000    ; ]
        mov cx, 2000    ; ] 2000 words = 4000 bytes
        repnz movsw

        mov ax, 2000
        call startoff

        mov ax, 0b800h ; ]
        mov es, ax     ; ]
        xor ax, ax     ; ]
        xor di, di     ; ] clear da screen at offset 0
        mov cx, 2000   ; ]
        repnz stosw          ; ]

        mov ax, 0b800h ; ]
        mov es, ax     ; ]
        xor ax, ax     ; ]
        mov di, 8000   ; ] clear da screen at offset 8000
        mov cx, 2000   ; ]
        repnz stosw    ; ]

        mov di, nposss
        mov cx, nposs

splitin_main:
        mov al, poss[di]
        dec di
        mov ah, poss[di]
        call setsplit
        dec di

        dec cx
        cmp cx, 10

        jne splitin_main

        push cs
        pop ds
        mov si, dx        ; offset of thingy to put on screen
        mov ax, 0b800h    ; ]
        mov es, ax        ; ] move to 0xb800, 0
        xor di, di        ; ]
        mov cx, 2000      ; ] 2000 words = 4000 bytes
        repnz movsw

        xor ax, ax
        call startoff
        call prerow

        ret
splitin ENDP

;#define prerow(firstrow) outport(0x3d4,0x08); outport(0x3d5,firstrow)

prerow PROC
        push ax
        push dx

        ; ax = firstrow
        mov dx, 03d4h
        push ax
        mov al, 8
        out dx, al
        inc dx
        pop ax
        out dx, al

        pop dx
        pop ax
        ret
prerow ENDP

hidecursor PROC
        mov ax,0100h
        mov cx,0800h
        int 10h
        ret
hidecursor ENDP

showcursor PROC
        mov ax,0100h
        mov cx,0607h
        int 10h
        ret
showcursor ENDP

; variables follow...

include rast.inc

include ansi.inc
include poss.inc

wh        db 1
nposs     dw 90
nposss    dw 180
buf       db 4000 dup(?)

exit:
        int 20h

END start
