package main

import "core:fmt"
import "core:os"
import "core:time"

main :: proc() {
	f, err := os.open("inputs/02.txt")
	if err != nil {
		fmt.printfln("Error opening file: %s", err)
		return
	}
	defer os.close(f)

	start := time.now()
	ans := day2_part1(f)
	end := time.now()
	fmt.printfln("Part 1: %d", ans)
	fmt.printfln("Time: %d", time.diff(start, end))
	os.seek(f, 0, os.SEEK_SET)

	start = time.now()
	ans = day2_part2(f)
	end = time.now()
	fmt.printfln("Part 2: %d", ans)
	fmt.printfln("Time: %d", time.diff(start, end))
}
