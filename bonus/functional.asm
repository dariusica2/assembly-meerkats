; Interpret as 64 bits code
[bits 64]

; nu uitati sa scrieti in feedback ca voiati
; assembly pe 64 de biti

section .text
global map
global reduce
map:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; sa-nceapa turneu'

    ; rdi holds *destination_array
    ; rsi holds *source_array
    ; rdx holds array_size
    ; rcx holds pointer to the function

    ; Saving the destination array in r8 so new values can be added in rdi
    mov r8, rdi
    ; Initialising the counter
    xor r9, r9

loop_map:
    ; Checking if the end of the array has been reached
    cmp r9, rdx
    jge done_map
    ; Size of element is 8 bytes
    ; In order to reach said element, we multiply r9 by 8 and add the value to the destination array address
    mov rdi, [rsi + r9 * 8]
    ; Calling the function with the rdi argument
    call rcx
    ; Value obtained via rcx will be stored in rax
    ; Putting value in the destination array
    mov [r8 + r9 * 8], rax
    ; Moving further in the array
    inc r9
    jmp loop_map

done_map:
    leave
    ret


; int reduce(int *dst, int *src, int n, int acc_init, int(*f)(int, int));
; int f(int acc, int curr_elem);
reduce:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; sa-nceapa festivalu'

    ; rdi holds *destination_array
    ; rsi holds *source_array
    ; rdx holds array_size
    ; rcx holds accumulator_initial_value
    ; r8 holds pointer to the function

    ; Saving the source array in r9 so new values can be added in rsi
    mov r9, rsi
    ; Initialising the counter
    xor r10, r10

loop_reduce:
    ; Checking if the end of the array has been reached
    cmp r10, rdx
    jge done_reduce
    ; Moving the accumulator in rdi to be used by the function
    mov rdi, rcx
    ; Size of element is 8 bytes
    ; In order to reach said element, we multiply r10 by 8 and add the value to the source array address
    ; Moving the element in rsi to be used by the function
    mov rsi, [r9 + 8 * r10]
    ; For preserving rdx 
    push rdx
    ; Call the function with the arguments rsi and rdi
    call r8
    ; Get rdx back
    pop rdx
    ; Value will be stored in rax, so new accumulator value will be the value from rax
    mov rcx, rax
    ; Moving further in the array
    inc r10
    jmp loop_reduce

done_reduce:
    leave
    ret

