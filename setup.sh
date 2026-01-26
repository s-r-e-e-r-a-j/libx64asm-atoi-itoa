#!/usr/bin/env bash

if ! command -v nasm &> /dev/null; then
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y nasm
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y nasm
    elif command -v yum &> /dev/null; then
        sudo yum install -y nasm
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm nasm
    else
        echo "No supported package manager found. Please install NASM manually."
        exit 1
    fi
fi

mkdir -p build
nasm -f elf64 src/atoi64.asm -o build/atoi64.o
nasm -f elf64 src/itoa64.asm -o build/itoa64.o
