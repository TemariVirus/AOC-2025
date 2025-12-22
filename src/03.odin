package main

import "core:bufio"
import "core:io"
import "core:os"
import "core:strings"


@(private = "file")
parse_input :: proc(f: os.Handle) -> [dynamic]string {
	r: bufio.Reader
	bufio.reader_init(&r, io.to_reader(os.stream_from_handle(f)))
	defer bufio.reader_destroy(&r)

	lines: [dynamic]string
	for {
		line, err := bufio.reader_read_string(&r, '\n')
		if len(line) == 0 {
			break
		}

		line = strings.trim_right(line, "\r\n")
		append(&lines, line)
	}
	return lines
}

@(private = "file")
max_index :: proc(s: []u8) -> int {
	idx := 0
	for c, i in s {
		if c > s[idx] {
			idx = i
		}
	}
	return idx
}

max_jolts :: proc(batteries: []u8, n: int) -> int {
	batteries := batteries
	jolts := 0
	for l := n - 1; l >= 0; l -= 1 {
		d := max_index(batteries[:len(batteries) - l])
		jolts = 10 * jolts + int(batteries[d] - '0')
		batteries = batteries[d + 1:]
	}
	return jolts
}

day3_part1 :: proc(f: os.Handle) -> int {
	lines := parse_input(f)
	defer delete(lines)

	sum := 0
	for line in lines {
		bytes := transmute([]u8)line
		sum += max_jolts(bytes, 2)
	}
	return sum
}

day3_part2 :: proc(f: os.Handle) -> int {
	lines := parse_input(f)
	defer delete(lines)

	sum := 0
	for line in lines {
		bytes := transmute([]u8)line
		sum += max_jolts(bytes, 12)
	}
	return sum
}
