module aoc_2025;
import day2;

import std::io;
import std::time;

fn int main(String[] args) {
    Clock clock = time::os::native_clock();

    char[] input = file::load(mem, "inputs/02.txt")!!;
    defer mem::free(input);

    clock.mark();
    long ans = day2::part1(input);
    NanoDuration dur = clock.mark();
    io::printf("Part 1: %d\nTime: %s\n\n", ans, dur);

    clock.mark();
    ans = day2::part2(input);
    dur = clock.mark();
    io::printf("Part 2: %d\nTime: %s\n", ans, dur);

    return 0;
}
