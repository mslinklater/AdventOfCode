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
    
    func cost(_ start: Galaxy, _ end: Galaxy) -> Int {
        var ret = 0
        let xMin = min(start.x, end.x)
        let xMax = max(start.x, end.x)
        let yMin = min(start.y, end.y)
        let yMax = max(start.y, end.y)
        var xPos = xMin + 1
        while xPos <= xMax {
            ret += xCost[xPos]
            xPos += 1
        }
        var yPos = yMin + 1
        while yPos <= yMax {
            ret += yCost[yPos]
            yPos += 1
        }
        return ret
    }
    
    override func run(filename: String, part: Int) -> Int {
        galaxies = [Galaxy]()
        xCost = [Int]() // map high costs, default is one
        yCost = [Int]()
        parseInput(filename: filename)
        var total = 0
        if part == 1 {
            for from in 0..<galaxies.count {
                for to in from + 1..<galaxies.count {
                    total += cost(galaxies[from], galaxies[to])
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
                xCost.append(1)
            } else {
                xCost.append(1000000)
            }
        }
        for i in 0..<iLine {
            if rowSet.contains(i) {
                yCost.append(1)
            } else {
                yCost.append(1000000)
            }
        }
    }
}
