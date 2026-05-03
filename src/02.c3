module day2;

import lib;
import std::io;
import std::math;

fn void parse_id(String str, long *parts, usz count, bool is_end) {
    if (str.len % count == 0) {
        usz n = str.len / count;
        for (usz i = 0; i < count; i++) {
            parts[i] = String.to_long(str[i * n .. (i + 1) * n - 1])!!;
        }
    } else {
        parts[0] = lib::powi(10, str.len / (int)count) - (is_end ? 1 : 0);
        for (usz i = 1; i < count; i++) {
            parts[i] = is_end ? parts[0] : 0;
        }
    }
}

fn long part1(char[] input) {
    long count = 0;
    Tokenizer tokenizer = lib::tokenizer(input, ',');
    while (try token = tokenizer.next()) {
        String start = token[0 .. token.index_of_char('-')!! - 1].trim("\r\n ");
        String end = token[token.index_of_char('-')!! + 1 ..].trim("\r\n ");

        long[2] start_parts, end_parts;
        parse_id(start, &start_parts, 2, false);
        parse_id(end, &end_parts, 2, true);

        for (long i = start_parts[0]; i <= end_parts[0]; i++) {
            if (i == start_parts[0] && i < start_parts[1]) continue;
            if (i == end_parts[0] && i > end_parts[1]) break;
            count += repeat(i, 2);
        }
    }
    return count;
}

fn long part2(char[] input) {
    long count = 0;
    Tokenizer tokenizer = lib::tokenizer(input, ',');
    while (try token = tokenizer.next()) {
        String start = token[0 .. token.index_of_char('-')!! - 1].trim("\r\n ");
        String end = token[token.index_of_char('-')!! + 1 ..].trim("\r\n ");

        long[19] start_parts, end_parts;
        for (int n = 2; n <= math::min((usz)end_parts.len, end.len); n++) {
            parse_id(start, &start_parts, n, false);
            parse_id(end, &end_parts, n, true);
            for OUTER: (long i = start_parts[0]; i <= end_parts[0]; i++) {
                for (int j = 0; j < n; j++) {
                    if (i < start_parts[j]) continue OUTER;
                    if (i == start_parts[j]) continue;
                    if (i > start_parts[j]) break;
                }
                for (int j = 0; j < n; j++) {
                    if (i < end_parts[j]) break;
                    if (i == end_parts[j]) continue;
                    if (i > end_parts[j]) continue OUTER;
                }

                int digits = lib::logi10(i) + 1;
                for (int j = 1; j < digits; j++) {
                    if (digits % j != 0) continue;
                    long subpattern = i % lib::powi(10, j);
                    if (subpattern == 0) continue;
                    if (i == repeat(subpattern, digits / j)) {
                        continue OUTER;
                    }
                }
                count += repeat(i, n);
            }
        }
    }
    return count;
}

fn long repeat(long x, int count) {
    int digits = lib::logi10(x) + 1;
    long base = lib::powi(10, digits);
    long acc = 0;
    for (int j = 0; j < count; j++) {
        acc *= base;
        acc += x;
    }
    return acc;
}
