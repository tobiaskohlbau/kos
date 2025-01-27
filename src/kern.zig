const __stack_top = @extern([*]u8, .{ .name = "__stack_top" });
const __bss = @extern([*]u8, .{ .name = "__bss" });
const __bss_end = @extern([*]u8, .{ .name = "__bss_end" });

inline fn memset(buf: [*]u8, c: u8, n: usize) [*]u8 {
    var i = n;
    while (i > 0) : (i -= 1) {
        buf[i] = c;
    }
    return buf;
}

export fn kernel_main() noreturn {
    @branchHint(.cold);
    _ = memset(__bss, 0, @intFromPtr(__bss_end) - @intFromPtr(__bss) + 5);

    while (true) {}
    unreachable;
}

export fn boot() linksection(".text.boot") callconv(.Naked) noreturn {
    @setRuntimeSafety(false);
    asm volatile (
        \\mv sp, %[stack_top]
        \\j kernel_main
        :
        : [stack_top] "r" (__stack_top),
    );
    unreachable;
}
