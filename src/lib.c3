module lib;

faultdef END;

struct Tokenizer {
    char[] s;
    char delim;
    usz pos;
}

fn Tokenizer tokenizer(char[] s, char delim) {
    return { s, delim, 0 };
}

fn String? Tokenizer.next(&self) {
    if (self.pos >= self.s.len) {
        return END~;
    }

    if (self.pos < self.s.len && self.s[self.pos] == self.delim) {
        self.pos++;
    }

    usz start = self.pos;
    while (self.pos < self.s.len && self.s[self.pos] != self.delim) {
        self.pos++;
    }

    if (start == self.pos) {
        return END~;
    }
    return (String)self.s[start..self.pos - 1];
}

fn long powi(long base, int power) {
    long acc = 1;
    while (power > 0) {
        if (power & 1 == 1) {
            acc *= base;
        }
        base *= base;
        power /= 2;
    }
    return acc;
}

fn int logi10(long x) {
    if (x == 0) unreachable("Cannot log 0");
    if (x < 10) return 0;
    if (x < 100) return 1;
    if (x < 1000) return 2;
    if (x < 10000) return 3;
    if (x < 100000) return 4;
    if (x < 1000000) return 5;
    if (x < 10000000) return 6;
    if (x < 100000000) return 7;
    if (x < 1000000000) return 8;
    if (x < 10000000000) return 9;
    if (x < 100000000000) return 10;
    if (x < 1000000000000) return 11;
    if (x < 10000000000000) return 12;
    if (x < 100000000000000) return 13;
    if (x < 1000000000000000) return 14;
    if (x < 10000000000000000) return 15;
    if (x < 100000000000000000) return 16;
    if (x < 1000000000000000000) return 17;
    return 18;
}
