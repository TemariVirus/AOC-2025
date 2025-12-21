module day1;

import lib;
import std::io;

fn long part1(char[] input) {
    long count = 0;
    int dial = 50;
    Tokenizer tokenizer = lib::tokenizer(input, '\n');
    while (try token = tokenizer.next()) {
        int sign = token[0] == 'R' ? 1 : -1;
        int diff = sign * String.to_int((String) token[1..])!!;
        dial = (dial + diff + 100) % 100;
        if (dial == 0) {
            count++;
        }
    }
    return count;
}

fn long part2(char[] input) {
    long count = 0;
    int dial = 50;
    Tokenizer tokenizer = lib::tokenizer(input, '\n');
    while (try token = tokenizer.next()) {
        int sign = token[0] == 'R' ? 1 : -1;
        int diff = String.to_int((String) token[1..])!!;
        count += diff / 100;
        diff = sign * (diff % 100);

        dial += diff;
        if (diff != dial && (dial <= 0 || dial >= 100)) {
            count++;
        }
        dial = (dial + 100) % 100;
    }
    return count;
}
