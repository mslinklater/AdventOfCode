//
//  Day11.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 11/12/2023.
//

import Foundation

class Day11 : DayBase {
    
    struct Galaxy {
        var x = 0
        var y = 0
    }
    var galaxies = [Galaxy]()
    var xCost = [Int]() // map high costs, default is one
    var yCost = [Int]()
    
    override func run(filename: String, part: Int) -> Int {
        galaxies = [Galaxy]()
        xCost = [Int]() // map high costs, default is one
        yCost = [Int]()
        parseInput(filename: filename)
        var total = 0
        if part == 1 {
            for from in 0..<galaxies.count {
                for to in from + 1..<galaxies.count {
                    
                }
            }
        } else {
            
        }
        return total
    }

    func process() {
        
    }
    
    func parseInput(filename: String) {
        let lines = fileAsLines(filename: filename)
        var colSet = Set<Int>()
        var rowSet = Set<Int>()
        var iLine = 0
        for line in lines {
            if line.count > 0 {
                var iChar = 0
                for char in line {
                    if char == "#" {
                        var newGalaxy = Galaxy()
                        newGalaxy.x = iChar
                        colSet.insert(iChar)
                        rowSet.insert(iLine)
                        newGalaxy.y = iLine
                        galaxies.append(newGalaxy)
                    }
                    iChar += 1
                }
                iLine += 1
            }
        }
        for i in 0..<lines[0].count {
            if colSet.contains(i) {
                xCost.append(2)
            } else {
                xCost.append(1)
            }
        }
        for i in 0..<iLine {
            if rowSet.contains(i) {
                yCost.append(2)
            } else {
                yCost.append(1)
            }
        }
    }
}
