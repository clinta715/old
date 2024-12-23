MAXRASTERS equ 895

include red.inc
include green.inc
include blue.inc

rasterbars PROC
    xor si,si;
    xor di,di;

RB_doloop:
                                            ; Start of rastercolors array, si=colorteller, di=byteteller...
         mov si,di                          ;
RB_loop:
                                            ; Color 0 (Background)
         mov dx,03c8h                       ;
         xor al,al                          ;
         out dx,al                          ;

         inc dx                             ;

         mov al, red_rasters[si]
         out dx,al                          ;

         mov al, green_rasters[si]
         out dx, al                         ;

         mov al, blue_rasters[si]           ;
         out dx, al                         ;

         inc si                             ;
         cmp si, MAXRASTERS                 ;
         jng RB_nozero                      ;
         mov si,0                           ;

RB_nozero:
         ; Check last scanline

         Mov Dx,03DAh;
         In Al,dx;
         Test Al,8;
         Jz RB_loop                         ; Zero (JZ)? Jump loop

         ; Not Zero (vertical retrace)

         inc di;
         cmp di,MAXRASTERS;
         jng RB_nozero2;
         xor di,di;
RB_nozero2:
    in al,60h;
    cmp al, 1;
    jne RB_doloop;

RB_endloop:
    xor ax, ax;
    mov dx, 03c8h;
    out dx, al;
    inc dx;
    out dx,al;
    out dx,al;
    out dx,al;
    ret;
rasterbars ENDP

