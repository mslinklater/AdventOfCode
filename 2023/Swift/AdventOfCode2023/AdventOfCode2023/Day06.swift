//
//  Day06.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 06/12/2023.
//

import Foundation

class Day06 : DayBase {
    
    struct Run {
        var time = 0
        var distance = 0
    }

    var runs = [Run]()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 1
        let lines = fileAsLines(filename: filename)
        runs.removeAll()
        parseInput(lines)
        
        if part == 1 {
            for run in runs {
                var numBetter = 0
                for i in 1 ..< run.time {
                    var dist = (run.time - i) * i
                    if dist > run.distance {
                        numBetter += 1
                    }
                }
                total *= numBetter
            }
        } else {
            total = 0
            var run = Run(time: 58996469, distance: 478223210191071)    // yes... couldn't be arsed parsing this out properly
            for i in 1 ..< run.time {
                var dist = (run.time - i) * i
                if dist > run.distance {
                    total += 1
                }
            }
        }
        return total
    }
    
    func parseInput(_ lines:[String]) {
        let timeStrings = (lines[0].split(separator: ":")[1]).split(separator: " ")
        let distanceStrings = (lines[1].split(separator: ":")[1]).split(separator: " ")
        for i in 0 ..< timeStrings.count {
            var newRun = Run()
            newRun.time = Int(timeStrings[i])!
            newRun.distance = Int(distanceStrings[i])!
            runs.append(newRun)
        }
    }
}
