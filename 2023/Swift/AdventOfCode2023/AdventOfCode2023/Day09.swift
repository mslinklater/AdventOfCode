//
//  Day09.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 09/12/2023.
//

import Foundation

func allZero(_ input: [Int]) -> Bool {
    for e in input {
        if e != 0 {
            return false
        }
    }
    return true
}

class Day09 : DayBase {
    
    struct Sequence {
        var lines = [[Int]]()   // array of int arrays
        
        mutating func setFirstLine(_ input: [Int]) {
            lines.append(input)
        }
        
        mutating func descend() {
            // descend the delta lines until bottom line is all zeroes
            var iCurrent = 0
            
            while(!allZero(lines[iCurrent])) {
                // create new line
                var newLine = [Int]()
                // fill in deltas
                for i in 0 ..< lines[iCurrent].count - 1 {
                    newLine.append(lines[iCurrent][i + 1] - lines[iCurrent][i])
                }
                lines.append(newLine)
                iCurrent += 1
            }
        }
        
        func nextBaseValue() -> Int {
            var sum = 0
            var row = lines.count - 2
            while row >= 0 {
                sum += lines[row][lines[row].count - 1]
                row -= 1
            }
            return sum
        }

        func prevBaseValues() -> Int {
            var endOfRow = 0
            var row = lines.count - 2
            while row >= 0 {
                endOfRow = lines[row][0] - endOfRow
                row -= 1
            }
            return endOfRow
        }
    }

    var sequences = [Sequence]()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 0
        sequences.removeAll()
        parseInput(filename:filename)
        if part == 1 {
            for s in sequences {
                total += s.nextBaseValue()
            }
        } else {
            for s in sequences {
                total += s.prevBaseValues()
            }
        }
        return total
    }
    
    func parseInput(filename: String) {
        let lines = fileAsLines(filename: filename)
        for line in lines {
            if line.count > 0 {
                var newSequence = Sequence()
                let stringElements = line.split(separator: " ")
                var intArray = [Int]()
                for element in stringElements {
                    intArray.append(Int(element)!)
                }
                newSequence.setFirstLine(intArray)
                newSequence.descend()
                sequences.append(newSequence)
            }
        }
    }
}
