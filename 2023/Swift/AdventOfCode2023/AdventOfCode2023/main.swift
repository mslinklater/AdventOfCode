//
//  main.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 26/11/2023.
//

import Foundation

print("Advent of Code 2023")

let day1 = Day01()
assert(day1.run(filename: "Day1Test1", part: 1) == 142)
print("---")
print("Day 1 part 1 = \(day1.run(filename: "Day1Part1", part: 1))")
assert(day1.run(filename: "Day1Test2", part: 2) == 281)
print("Day 1 part 2 = \(day1.run(filename: "Day1Part1", part: 2))")
