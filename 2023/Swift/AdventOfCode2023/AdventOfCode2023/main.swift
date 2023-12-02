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
print("Day 1 part 1 = \(day1.run(filename: "Day1Input", part: 1))")
assert(day1.run(filename: "Day1Test2", part: 2) == 281)
print("Day 1 part 2 = \(day1.run(filename: "Day1Input", part: 2))")

let day2 = Day02()
assert(day2.run(filename: "Day2Test1", part: 1) == 8)
print("Day 2 part 1 = \(day2.run(filename: "Day2Input", part: 1))")
assert(day2.run(filename: "Day2Test1", part: 2) == 2286)
print("Day 2 part 2 = \(day2.run(filename: "Day2Input", part: 2))")
