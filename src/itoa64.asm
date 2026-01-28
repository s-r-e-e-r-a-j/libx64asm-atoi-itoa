; Developer: Sreeraj 
; GitHub: https://github.com/s-r-e-e-r-a-j 

section .text
global itoa64

itoa64:
    push rbx
    mov rax, rdi
    mov rbx, rsi
    xor rcx, rcx

    cmp rax, 0
    jge .conv
    neg rax
    mov byte [rsi], '-'
    inc rsi
    inc rcx

.conv:
    cmp rax, 0
    jne .loop
    mov byte [rsi], '0'
    inc rcx
    jmp .digits_done

.loop:
    xor rdx, rdx
    mov r8, 10
    div r8
    add dl, '0'
    mov [rsi], dl
    inc rsi
    inc rcx
    test rax, rax
    jne .loop

.digits_done:
    lea rdi, [rbx]
    cmp byte [rdi], '-'
    jne .rev
    inc rdi

.rev:
    lea rsi, [rbx + rcx - 1]

.swap:
    cmp rdi, rsi
    jge .finish
    mov al, [rdi]
    mov bl, [rsi]
    mov [rdi], bl
    mov [rsi], al
    inc rdi
    dec rsi
    jmp .swap

.finish:
    mov byte [rbx + rcx], 0
    mov rax, rcx
    pop rbx
    ret
