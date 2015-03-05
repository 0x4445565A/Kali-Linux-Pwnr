;nasm boot.asm -f bin -o boot.bin
;qemu-system-i386 boot.bin
[BITS 16]
[ORG 0x7C00]

CALL Loop
JMP $

Loop:
 CALL Delay
 CALL ClearBuffer
 CALL FrameOne
 CALL Delay
 CALL ClearBuffer
 CALL FrameTwo
 CALL Loop
RET

Delay:
 MOV BP, 2000
 MOV SI, 2000
 SubDelay:
   DEC BP
   JNZ SubDelay
   DEC SI
   CMP SI, 0    
   JNZ SubDelay
RET

ClearBuffer:
 MOV AH, 6
 MOV AL, 50
 MOV BH, 7
 MOV CH, 0
 MOV CL, 0
 MOV DH, 24
 MOV DL, 79
 INT 0x10
RET

PrintChar:
 MOV AH, 0x0E
 MOV BH, 0x00
 MOV BL, 0x07
 INT 0x10
RET

Print:
 next:
   MOV  AL, [SI]
   INC  SI
   OR   AL, AL
   JZ   return
   CALL PrintChar
   JMP  next
 return:
RET

StaticBanner:
 MOV  SI, Banner
 CALL Print
RET

FrameOne:
 CALL StaticBanner
 MOV  SI, Frame1
 CALL Print
RET

FrameTwo:
 CALL StaticBanner
 MOV  SI, Frame2
 CALL Print
RET

Banner DB 0xA, 0xD, 0xA, 0xD
       DB '########################################################', 0xA, 0xD
       DB '#            Kali Linux Pwnr v0.1 by TehBmar           #', 0xA, 0xD
       DB '#                                                      #', 0xA, 0xD
       DB '# Greetz to the PREMIER Alaska hacking Channel #akhax  #', 0xA, 0xD
       DB '########################################################', 0xA, 0xD, 0xA, 0xD
       DB 0

Frame1 DB 0xA, 0xD, 0xA, 0xD
       DB "(>'-')> you done fucked up now!", 0xA, 0xD
       DB 0

Frame2 DB 0xA, 0xD, 0xA, 0xD
       DB "(^'-')^ you done fucked up now!", 0xA, 0xD
       DB 0

TIMES 510 - ($ - $$) DB 0
DW 0xAA55
