; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    push ebp
    mov ebp, esp

    ;; save the preserved registers
    push ebx
    push esi
    push edi

    ;; recursive bsearch implementation goes here

    ;; Function uses fastcall attribute
    ;; ecx holds the array address
    ;; edx holds the (value of the) needle
    ;; esi holds the start position
    mov esi, [ebp + 8]
    ;; edi holds the end position
    mov edi, [ebp + 12]
    ;; Initially assuming that the needle is not found
    mov eax, -1
    ;; Checking if the condition of end >= start is met
    cmp esi, edi
    jg done
    ;; Finding the middle value and storing it in ebx
    mov ebx, esi
    add ebx, edi
    ;; Dividing by 2
    shr ebx, 1
    ;; Comparing the needle with the middle value
    ;; If they're equal, the needle has been found (in the haystack)
    ;; If the needle is greater than the middle value, the search continues in the right side
    cmp edx, [ecx + 4 * ebx]
    je found_needle
    jg right_search

left_search:
    ;; In the left search, only the end position changes and it becomes (middle - 1)
    mov edi, ebx
    dec edi
    push edi
    push esi
    call binary_search
    ;; Clearing the stack
    add esp, 8
    jmp done

right_search:
    ;; In the right search, only the start position changes and it becomes (middle + 1)
    mov esi, ebx
    inc esi
    push edi
    push esi
    call binary_search
    ;; Clearing the stack
    add esp, 8
    jmp done

found_needle:
    ;; Saving the position where the needle is found in eax
    mov eax, ebx

    ;; restore the preserved registers

done:
    pop edi
    pop esi
    pop ebx
    leave
    ret
