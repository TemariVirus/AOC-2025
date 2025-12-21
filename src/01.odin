package main

import "core:bufio"
import "core:io"
import "core:os"
import "core:strconv"
import "core:strings"

parse_input :: proc(f: os.Handle) -> [dynamic]int {
	r: bufio.Reader
	bufio.reader_init(&r, io.to_reader(os.stream_from_handle(f)))
	defer bufio.reader_destroy(&r)

	rots: [dynamic]int
	for {
		line, err := bufio.reader_read_string(&r, '\n')
		if err != nil {
			break
		}
		defer delete(line)

		line = strings.trim_right(line, "\r\n")
		is_neg := line[0] == 'L'
		rot, ok := strconv.parse_int(line[1:], 10)
		assert(ok)

		if is_neg {
			rot = -rot
		}
		append(&rots, rot)
	}
	return rots
}

day1_part1 :: proc(f: os.Handle) -> int {
	rots := parse_input(f)
	defer delete(rots)

	count := 0
	pos := 50
	for rot in rots {
		pos = (pos + rot) % 100
		if pos == 0 {
			count += 1
		}
	}
	return count
}

day1_part2 :: proc(f: os.Handle) -> int {
	rots := parse_input(f)
	defer delete(rots)

	count := 0
	pos := 50
	for rot in rots {
		count += abs(rot) / 100
		dr := rot > 0 ? 1 : -1
		for i := 0; i < abs(rot % 100); i += 1 {
			pos = (pos + dr + 100) % 100
			if pos == 0 {
				count += 1
			}
		}
	}
	return count
}
