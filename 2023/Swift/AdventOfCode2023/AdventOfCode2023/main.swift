//
//  main.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 26/11/2023.
//

import Foundation

print("Advent of Code 2023")

extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
}

let day1 = Day01()
assert(day1.run(filename: "Day1Test1.txt", part: 1) == 142)
print("---")
print("Day 1 part 1 = \(day1.run(filename: "Day1Part1", part: 1))")
assert(day1.run(filename: "Day1Test2", part: 2) == 281)
print("Day 1 part 2 = \(day1.run(filename: "Day1Part1", part: 2))")
