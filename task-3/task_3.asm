%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

section .bss
; Vector for keeping track of visited nodes.
visited resd 10000
global visited

section .data
; Format string for printf.
fmt_str db "%u", 10, 0

section .text
global dfs
extern printf

; C function signiture:
;   void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
; 
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:
    push ebp
    mov ebp, esp

    ; TODO: Implement the depth first search algorith, using the `expand`
    ; function to get the neighbours. When a node is visited, print it by
    ; calling `printf` with the format string in section .data.

    ;; Void function so it doesn't return anything
    pusha
    ;; Getting the function arguments and storing them
    ;; eax holds the node
    mov eax, [ebp + 8]
    ;; ebx holds pointer to expand function
    mov ebx, [ebp + 12]
    ;; Size of integer is 4 (uint32_t)
    ;; Marking the node as visited
    mov dword [visited + 4 * eax], 1
    ;; Setting up the scene for the printf function
    push eax
    push fmt_str
    call printf
    ;; Popping the stack twice because add esp, 8 doesn't work
    ;; Yes, I know why it doesn't work
    pop eax
    pop eax
    ;; Applying the expand function to the node
    push eax
    call ebx
    ;; Adding 4 to esp to keep the value of eax
    add esp, 4
    ;; eax now holds the pointer to the structure which has the number of neighbors and the address of the array
    ;; edx holds the number of neighbors
    mov edx, [eax]
    ;; esi holds the address of the neighbors array
    ;; [eax + 4] because the number of neighbors is 4 bytes and the offset to reach the address is 4
    mov esi, [eax + 4]
    ;; Initialising the counter
    xor ecx, ecx
loop:
    ;; Checking if the end of the array was reached
    cmp edx, ecx
    jz done
    ;; Size of node is 4 bytes, and esi holds the array address so
    mov edi, [esi + 4 * ecx]
    ;; Checking if the node has already been visited
    cmp dword [visited + 4 * edi], 1
    jz skip_node
    ;; Pushing the expand function first and then the node to recursively call dfs
    push ebx
    push edi
    call dfs
    pop edi
    pop ebx
skip_node:
    ;; Moving further in the array
    inc ecx
    jmp loop

done:
    ;; Void function so it doesn't return anything
    popa
    leave
    ret
