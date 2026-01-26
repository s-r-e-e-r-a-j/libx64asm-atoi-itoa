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

## Build Instructions
Make `setup.sh` executable and run it:
```Bash
chmod +x setup.sh
./setup.sh
```
- Installs NASM if missing (supports Debian, RHEL, Arch)
- Assembles `atoi64.asm` and `itoa64.asm` into `.o` files in `build/`

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

