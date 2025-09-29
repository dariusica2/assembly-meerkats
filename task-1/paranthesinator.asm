; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp

    ; sa-nceapa concursul

    ;; Saving the preserved registers
    push ebx
    push esi
    ;; Loading the address of the string in esi
    mov esi, [ebp + 8]
    ;; Starting with the assumption that the parantheses are correctly closed
    mov eax, 0
    ;; Reading the elements of the string one by one
    ;; The initial number of elements in the stack is 0
    xor ecx, ecx

read_elements:
    mov bl, byte [esi]
    ;; Checks if the end of the array has been reached
    test bl, bl
    jz check_stack
    ;; If the character is any type of open paranthesis, it is added to the stack
    cmp bl, '('
    je put_in_stack
    cmp bl, '['
    je put_in_stack
    cmp bl, '{'
    je put_in_stack
    ;; If the character is a closed paranthesis, we check if it matches the one that was last added in the stack
    cmp bl, ')'
    je erase_round_from_stack
    cmp bl, ']'
    je erase_square_from_stack
    cmp bl, '}'
    je erase_squiggly_from_stack

put_in_stack:
    movzx ebx, bl
    ;; Pushes ebx onto the stack
    push ebx
    ;; Increases number of elements in stack
    inc ecx
    ;; Move to the next character
    inc esi
    jmp read_elements

erase_round_from_stack:
    ;; Checking if the stack is empty; if it is, it means that the parantheses are not correctly closed
    cmp ecx, 0
    je failure
    ;; Decreasing the number of elements inside the stack
    dec ecx
    ;; Moving to the next character in the array
    inc esi
    ;; Checking if the last element in the stack is the right one
    pop ebx
    cmp ebx, '('
    je read_elements
    jmp failure

erase_square_from_stack:
    ;; Checking if the stack is empty; if it is, it means that the parantheses are not correctly closed
    cmp ecx, 0
    je failure
    ;; Decreasing the number of elements inside the stack
    dec ecx
    ;; Moving to the next character in the array
    inc esi
    ;; Checking if the last element in the stack is the right one
    pop ebx
    cmp ebx, '['
    je read_elements
    jmp failure

erase_squiggly_from_stack:
    ;; Checking if the stack is empty; if it is, it means that the parantheses are not correctly closed
    cmp ecx, 0
    je failure
    ;; Decreasing the number of elements inside the stack
    dec ecx
    ;; Moving to the next character in the array
    inc esi
    ;; Checking if the last element in the stack is the right one
    pop ebx
    cmp ebx, '{'
    je read_elements
    jmp failure

check_stack:
    ;; Checks if there are elements left in the stack
    cmp ecx, 0
    jne empty_stack
    jmp done

empty_stack:
    ;; Pops each remaining element in the stack
    pop ebx
    dec ecx
    jmp check_stack

failure:
    ;; If the parantheses are not correctly closed off, eax will become 1
    mov eax, 1
    jmp check_stack

done:
    pop esi
    pop ebx
    leave
    ret
