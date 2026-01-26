#!/bin/bash
if ! command -v nasm &> /dev/null; then
    sudo apt update
    sudo apt install -y nasm
fi

mkdir -p build
nasm -f elf64 src/atoi64.asm -o build/atoi64.o
nasm -f elf64 src/itoa64.asm -o build/itoa64.o
