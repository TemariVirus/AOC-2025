module day3;

import lib;
import std::io;
import std::math;

fn usz max_idx(String str) {
    char max = str[0];
    usz idx = 0;
    for (int i = 1; i < str.len; i++) {
        if (str[i] > max) {
            max = math::max(max, str[i]);
            idx = i;
        }
    }
    return idx;
}

fn long solution(char[] input, int n) {
    long total = 0;
    Tokenizer tokenizer = lib::tokenizer(input, '\n');
    while (try token = tokenizer.next()) {
        long joltage = 0;
        String remaining = token;
        for (int i = 0; i < n; i++) {
            String viable = remaining[0 .. remaining.len - n + i];
            usz idx = max_idx(viable);
            joltage *= 10;
            joltage += (long)viable[idx] - '0';
            remaining = remaining[idx + 1 ..];
        }
        total += joltage;
    }
    return total;
}

fn long part1(char[] input) {
    return solution(input, 2);
}

fn long part2(char[] input) {
    return solution(input, 12);
}
