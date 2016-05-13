.equ SWI_DRAW_STRING, 0x204 @display a string on LCD
.equ SWI_CLEAR_DISPLAY,0x206 @clear LCD
.equ SWI_CLEAR_LINE, 0x208 @clear a line on LCD
.equ SWI_EXIT, 0x11 @terminate program



@Clear the board, clear the LCD screen
swi SWI_CLEAR_DISPLAY
@draw a message to the lcd screen on line#1, column 4
mov r0,#4 @ column number
mov r1,#1 @ row number
ldr r2,=screensaver @ pointer to string
swi SWI_DRAW_STRING @ draw to the LCD screen
mov r0,#0 @ column number
mov r1,#0 @ row number
b wait

check:
   cmp r0,#40
   bne draw 
   mov r0,#0
   mov r1,#0


draw:
@Clear the board, clear the LCD screen
swi SWI_CLEAR_DISPLAY
@draw a message to the lcd screen on line#2, column 4
ldr r2,=Windows @ pointer to string
swi SWI_DRAW_STRING @ draw to the LCD screen
add r0,r0,#5
add r1,r1,#1 


@Wait for 3 second
wait:
     mov r3,#0
     loop:
       cmp r3,#1<<20
       beq check
       add r3,r3,#1
       b loop

.data
screensaver: .asciz "Screen Saver..."
Windows: .asciz "Windows"

.end