module day4;

import lib;
import std::io;
import std::collections::list;

fn bool[][] solution(char[] input) {
    long total = 0;
    List{bool[]} map;
    Tokenizer tokenizer = lib::tokenizer(input, '\n');
    while (try line = tokenizer.next()) {
        if (line.len == 0) break;

        bool* row = malloc(line.len * bool.sizeof);
        for (int i = 0; i < line.len; i++) {
            row[i] = line[i] == '@';
        }
        map.push(row[0..line.len - 1]);
    }
    return map.to_tarray();
}

fn long remove_all(bool[][] map, bool[][] new_map) {
    long count = 0;
    for (int y = 0; y < map.len; y++) {
        for (int x = 0; x < map[y].len; x++) {
            if (!map[y][x]) continue;

            int neigh = 0;
            for (int dy = -1; dy <= 1; dy++) {
                if (y + dy < 0 || y + dy >= map.len) continue;
                for (int dx = -1; dx <= 1; dx++) {
                    if (dx == 0 && dy == 0) continue;
                    if (x + dx < 0 || x + dx >= map[y].len) continue;
                    neigh += map[y + dy][x + dx] ? 1 : 0;
                }
            }
            new_map[y][x] = neigh >= 4;
            count += new_map[y][x] ? 0 : 1;
        }
    }
    return count;
}

fn long part1(char[] input) {
    bool[][] map = solution(input);
    bool[][] map2 = solution(input);
    return remove_all(map, map2);
}

fn long part2(char[] input) {
    bool[][] map = solution(input);
    bool[][] map2 = solution(input);
    long total = 0;
    long count;
    do {
        count = remove_all(map, map2);
        total += count;
        bool[][] tmp = map;
        for (int y = 0; y < map2.len; y++) {
            for (int x = 0; x < map2[y].len; x++) {
                map[y][x] = map2[y][x];
            }
        }
    } while (count > 0);
    return total;
}
