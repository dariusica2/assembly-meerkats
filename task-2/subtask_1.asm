; subtask 1 - qsort

%include "../include/io.mac"
;PRINTF32 `%d\n\x0`, ecx
section .text
    global quick_sort
    ;; no extern functions allowed
    extern printf

quick_sort:
    ;; create the new stack frame
    push ebp
    mov ebp, esp

    ;; save the preserved registers
    push ebx
    push esi
    push edi

    ;; recursive qsort implementation goes here

    ;; Getting the function arguments and storing them
    ;; esi holds the address of the array
    mov esi, [ebp + 8]
    ;; ecx holds the start position
    mov ecx, [ebp + 12]
    ;; edx holds the end position
    mov edx, [ebp + 16]

    ;; Checking if the start point is greater than or the same as the end point
    cmp ecx, edx
    jge done
    ;; ebx will hold the pivot
    ;; The pivot is the last element of the array
    ;; We get to the end of the array by multiplying edx with 4 (the size of an int32_t value)
    ;; and adding it to the address start
    mov ebx, [esi + edx * 4]
    ;; edi represents the first pointer (i)
    ;; i = start - 1
    mov edi, ecx
    dec edi
    ;; eax represents the second pointer (j)
    mov eax, ecx
    ;; For the loop, I basically recreated this 'for-loop'
    ;; for (int j = start; j < end; j++) {
        ;; if (array[j] <= pivot) {
            ;; i++;
            ;; swap(&array[i], &array[j]);
        ;; }
    ;; }
loop:
    ;; Checking if j is greater than or equal the end position
    cmp eax, edx
    jge loop_done
    ;; Checking if the pivot is less than the value on the j-th position in the array
    ;; Skipping the swap if that is the case
    ;; Multiplied by 4 because size of int32_t is 4 bytes
    cmp ebx, [esi + eax * 4]
    jl skip_swap
    ;; Start of the swap
    ;; Increasing the first pointer (the position in the array to where it points)
    inc edi
    ;; Preserving these two registers because I use them temporarily for the swap
    push ecx
    push edx
    ;; Le swap
    ;; Size of int32_t is 4
    mov ecx, [esi + edi * 4]
    ;; Size of int32_t is 4
    mov edx, [esi + eax * 4]
    ;; Size of int32_t is 4
    mov [esi + eax * 4], ecx
    ;; Size of int32_t is 4
    mov [esi + edi * 4], edx
    ;; Getting back the initial registers
    pop edx
    pop ecx

skip_swap:
    ;; Just moves on to the next element
    inc eax
    jmp loop

loop_done:
    ;; Swapping array[i + 1] and array[end]
    ;; Increasing the position of the first pointer by one
    inc edi
    ;; Preserving these two registers because I use them temporarily for the swap
    push eax
    push ebx
    ;; Le swap
    ;; Size of int32_t is 4
    mov eax, [esi + edi * 4]
    ;; Size of int32_t is 4
    mov ebx, [esi + edx * 4]
    ;; Size of int32_t is 4
    mov [esi + edx * 4], eax
    ;; Size of int32_t is 4
    mov [esi + edi * 4], ebx
    ;; Getting back the initial registers
    pop ebx
    pop eax
    ;; Calling quicksort using start and (pivot - 1)
    ;; edi holds current value (pivot) so it gets decreased by one
    dec edi
    ;; Preserving edx
    push edx
    push edi
    push ecx
    push esi
    call quick_sort
    ;; Eliminating first 3 (4 byte) values from the stack
    add esp, 12
    ;; Getting edx back
    pop edx
    ;; Calling quicksort using (pivot + 1) and end
    ;; edi holds current value (pivot - 1) so it gets increased by two
    add edi, 2
    push edx
    push edi
    push esi
    call quick_sort
    ;; Eliminating first 3 (4 byte) values from the stack
    add esp, 12
    ;; restore the preserved registers
done:
    pop edi
    pop esi
    pop ebx
    leave
    ret
