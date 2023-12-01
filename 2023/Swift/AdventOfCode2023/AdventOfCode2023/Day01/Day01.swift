//
//  day01.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 26/11/2023.
//

import Foundation

// Not used to what string handling APIs Swift/Foundation has yet
// so this solution is probably a bit crap

// Algo - part 1 was a simple first/last character predicate search but then part 2
// added word number descriptions, which made things a bit messier.

class Day01 : DayBase {
    override func run(filename: String, part: Int) -> Int {
        let input = fileAsLines(filename: filename)
        var total = 0
        var firstValue = 0  // numeric value of the first (leftmost) value in the source line
        var lastValue = 0   // numeric value of the last (rightmost) value in the source line
        
        var substrings = ["0": 0,   // substrings to search for and their numeric values
                            "1": 1,
                            "2": 2,
                            "3": 3,
                            "4": 4,
                            "5": 5,
                            "6": 6,
                            "7": 7,
                            "8": 8,
                            "9": 9 ]

        if part == 2 {
            substrings["zero"] = 0
            substrings["one"] = 1
            substrings["two"] = 2
            substrings["three"] = 3
            substrings["four"] = 4
            substrings["five"] = 5
            substrings["six"] = 6
            substrings["seven"] = 7
            substrings["eight"] = 8
            substrings["nine"] = 9
        }
        
        for line in input {
            if !line.isEmpty {
                var firstIndex: Int?
                var lastIndex: Int?
  
                for key in substrings.keys {
                    let indices = line.indicesOf(string: key)
                    for i in indices {
                        if firstIndex == nil || i < firstIndex!{
                            firstIndex = i
                            firstValue = substrings[key]!
                        }
                        if lastIndex == nil || i > lastIndex!{
                            lastIndex = i
                            lastValue = substrings[key]!
                        }
                    }
                }
                let val = (firstValue * 10) + lastValue
                total += val
            }
        }
        return total
    }
}
