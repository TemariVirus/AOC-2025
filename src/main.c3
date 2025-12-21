module aoc_2025;
import day1;

import std::io;
import std::time;

fn int main(String[] args) {
    Clock clock = time::os::native_clock();

    char[] input = file::load(mem, "inputs/01.txt")!!;
    defer mem::free(input);

    clock.mark();
    long ans = day1::part1(input);
    NanoDuration dur = clock.mark();
    io::printf("Part 1: %d\nTime: %s\n\n", ans, dur);

    clock.mark();
    ans = day1::part2(input);
    dur = clock.mark();
    io::printf("Part 2: %d\nTime: %s\n", ans, dur);

    return 0;
}
