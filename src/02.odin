package main

import "core:bufio"
import "core:io"
import "core:os"
import "core:strconv"
import "core:strings"

@(private = "file")
Range :: struct {
	start: int,
	end:   int,
}

@(private = "file")
parse_input :: proc(f: os.Handle) -> [dynamic]Range {
	r: bufio.Reader
	bufio.reader_init(&r, io.to_reader(os.stream_from_handle(f)))
	defer bufio.reader_destroy(&r)


	ranges: [dynamic]Range
	for {
		range_btyes, err := bufio.reader_read_slice(&r, ',')
		if len(range_btyes) == 0 {
			break
		}

		range := strings.trim(string(range_btyes), ",\r\n")
		split := strings.index_byte(range, '-')
		assert(split >= 0)

		s, ok1 := strconv.parse_int(range[:split], 10)
		e, ok2 := strconv.parse_int(range[split + 1:], 10)
		assert(ok1 && ok2)
		append(&ranges, Range{start = s, end = e})
	}
	return ranges
}

day2_part1 :: proc(f: os.Handle) -> int {
	ranges := parse_input(f)
	defer delete(ranges)

	buf: [20]u8
	sum := 0
	for r in ranges {
		for i := r.start; i <= r.end; i += 1 {
			s := strconv.write_int(buf[:], i64(i), 10)
			pivot := len(s) / 2
			if s[:pivot] == s[pivot:] {
				sum += i
			}
		}
	}

	return sum
}

day2_part2 :: proc(f: os.Handle) -> int {
	ranges := parse_input(f)
	defer delete(ranges)

	buf: [20]u8
	sum := 0
	for r in ranges {
		for i := r.start; i <= r.end; i += 1 {
			s := strconv.write_int(buf[:], i64(i), 10)
			repeat_check: for l := 1; l <= len(s) / 2; l += 1 {
				if len(s) % l != 0 {
					continue
				}
				for j := l; j < len(s); j += l {
					if s[:l] != s[j:][:l] {
						continue repeat_check
					}
				}

				sum += i
				break
			}
		}
	}

	return sum
}
