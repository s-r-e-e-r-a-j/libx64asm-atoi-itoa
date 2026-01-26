# libx64asm-atoi-itoa
An x86-64 assembly library for converting integers to ASCII (itoa64) and ASCII to integers (atoi64).
Supports signed 64-bit integers (positive and negative).
Can be used in Linux programs, bootloaders, or kernels.

## Features
- Convert signed 64-bit integers → ASCII (itoa64)
- Convert ASCII → signed 64-bit integers (atoi64)
- Null-terminated strings
- Minimal and fast
- Works on major Linux distributions

## Files
- `src/atoi64.asm` — ASCII → integer
- `src/itoa64.asm` — integer → ASCII
- `setup.sh` — installs NASM if missing and builds `.o` files
- `build/` — folder for assembled object files

## Clone the Repository
**Clone the repository first:**
```bash
git clone https://github.com/s-r-e-e-r-a-j/libx64asm-atoi-itoa.git
```
**Navigate to the project directory:** 
```bash
cd libx64asm-atoi-itoa
```
After cloning and navigating to the project directory, follow the Build Instructions section.

## Build Instructions
Make `setup.sh` executable and run it:
```bash
chmod +x setup.sh
./setup.sh
```
- Installs NASM if missing (supports Debian, RHEL, Arch)
- Assembles `atoi64.asm` and `itoa64.asm` into `.o` files in `build/`
- After running `setup.sh`, the object files for the library will be in the `build/` folder.
- You will need to link the `.o` files in the `build/` folder when compiling your own programs.

## Functions
`atoi64`
- Input:
  - `RDI` → pointer to null-terminated ASCII string
- Output:
  - `RAX` → signed 64-bit integer

`itoa64`
- Input:
  - `RDI` → signed 64-bit integer
  - `RSI` → pointer to output buffer
- Output:
  - `RAX` → string length (without null byte)
  - Output buffer is null-terminated

## Linking with the Library
After running `setup.sh`, the library object files are created in the `build/` folder:
```bash
build/atoi64.o
build/itoa64.o
```
When you build your own program, you must link these object files.

Example

```bash
nasm -f elf64 main.asm -o main.o
ld -o main main.o build/atoi64.o build/itoa64.o -e _start
```
If your program is in another directory
Use the path to the build/ folder:

```bash
nasm -f elf64 main.asm -o main.o
ld -o main main.o \
../libx64asm-atoi-itoa/build/atoi64.o \
../libx64asm-atoi-itoa/build/itoa64.o \
-e _start
```
**Important**
 - The library is not installed system-wide
- Only the `.o` files in `build/` are needed
- Always include them when linking

## Linking Only What You Use
You only need to link the object file for the function you use.
- If you use `atoi64` only, link `atoi64.o`
- If you use `itoa64` only, link `itoa64.o`
- If you use both, link both files
  
**Examples**

Using only `atoi64:`

```bash
ld -o program program.o build/atoi64.o -e _start
```
Using only `itoa64:`
```bash
ld -o program program.o build/itoa64.o -e _start
```
Using both:
```bash
ld -o program program.o build/atoi64.o build/itoa64.o -e _start
```
From another directory
```bash
ld -o program program.o \
../libx64asm-atoi-itoa/build/atoi64.o \
-e _start
```
or
```bash
ld -o program program.o \
../libx64asm-atoi-itoa/build/itoa64.o \
-e _start
```

## Example: `atoi64`

```asm
global _start
extern atoi64

section .data
    input db "-12345", 0 ; input string

section .text
_start:
    mov rdi, input ; string address
    call atoi64 ; convert to number

    ; rax now holds the result

    mov rax, 60 ; exit syscall
    xor rdi, rdi ; exit code 0
    syscall
```

**Build:**
```bash
nasm -f elf64 example_atoi.asm -o example_atoi.o
ld -o example_atoi example_atoi.o build/atoi64.o -e _start
```

## Example: `itoa64`

```asm
global _start
extern itoa64

section .bss
    buffer resb 32  ; output buffer

section .text
_start:
    mov rdi, -9876  ; number to convert
    mov rsi, buffer ; buffer address
    call itoa64 ; convert to string

; buffer now has the text

    mov rax, 60 ; exit syscall
    xor rdi, rdi ; exit code 0
    syscall
```

**Build:**
```bash
nasm -f elf64 example_itoa.asm -o example_itoa.o
ld -o example_itoa example_itoa.o build/itoa64.o -e _start
```

## License
This project is licensed under the MIT License
