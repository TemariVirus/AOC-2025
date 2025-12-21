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

fn char[]? Tokenizer.next(&self) {
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
    return self.s[start..self.pos - 1];
}
