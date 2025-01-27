#!/usr/bin/env bash

set -xeu

QEMU=qemu-system-riscv32

zig build

$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot -kernel zig-out/bin/kos
