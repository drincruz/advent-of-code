    .syntax unified

    @ -------------------------

.global main
.section .text

main:
    @ Found this hello, world on youtube https://www.youtube.com/watch?v=FV6P5eRmMh8
    mov r7, #0x4
    mov r0, #1
    ldr r1, =message
    mov r2, #14
    swi 0

    mov r7, #0x1
    mov r0, #65
    swi 0

    @ -------------------------
    @ Data section
.section .data
message:
    .asciz "hello, world.\n"
