section .text
global atoi64

atoi64:
    xor rax, rax
    xor rcx, rcx

.skip:
    mov bl, [rdi]
    cmp bl, ' '
    jne .sign
    inc rdi
    jmp .skip

.sign:
    cmp bl, '-'
    jne .parse
    inc rdi
    mov rcx, 1

.parse:
    mov bl, [rdi]
    cmp bl, '0'
    jb .done
    cmp bl, '9'
    ja .done
    sub bl, '0'
    movzx rbx, bl
    imul rax, rax, 10
    add rax, rbx
    inc rdi
    jmp .parse

.done:
    test rcx, rcx
    jz .ret
    neg rax

.ret:
    ret
