//
//  Day06.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 06/12/2023.
//

import Foundation

func lcf(_ first: Int, _ second: Int) -> Int {
    var f = first
    var s = second
    while f != s {
        if f > s {
            f = f - s
        } else {
            s = s - f
        }
    }
    return f
}

class Day08 : DayBase {
    
    struct Node {
        var left = ""
        var right = ""
    }

    var nodes = [String:Node]()

    var directions = ""
    
    func numStepsFor( _ start: String, _ end: String) -> Int {
        var iCount = 0
        var steps = 0
        var current = start
        while !current.hasSuffix(end) {
            switch directions[directions.index(directions.startIndex, offsetBy: iCount)] {
            case "L":
                current = nodes[current]!.left
            case "R":
                current = nodes[current]!.right
            default:
                assert(false)
            }
            iCount += 1
            iCount %= directions.count
            steps += 1
        }
        return steps
    }

    func findFactor( _ start: String, _ end: String) -> Int {
        var iCount = 0
        var steps = 0
        var current = start
        while true {
            if current.hasSuffix(end) {
                return steps
            }
            switch directions[directions.index(directions.startIndex, offsetBy: iCount)] {
            case "L":
                current = nodes[current]!.left
            case "R":
                current = nodes[current]!.right
            default:
                assert(false)
            }
            iCount += 1
            iCount %= directions.count
            steps += 1
        }
    }

    override func run(filename: String, part: Int) -> Int {
        var total = 0
        let lines = fileAsLines(filename: filename)
        parseInput(lines)
        
        if part == 1 {
            total += numStepsFor("AAA", "ZZZ")
        } else {
            var factors = [Int]()
            for (key, _) in nodes {
                if key.hasSuffix("A") {
                    factors.append(findFactor(key, "Z"))
                }
            }
            total = factors[0]
            for i in 1 ..< factors.count {
                total = total * factors[i] / lcf(total, factors[i])
            }
        }
        return total
    }
    
    func parseInput(_ lines:[String]) {
        directions = lines[0]
        for i in 2 ..< lines.count {
            if lines[i].count > 0 {
                var newNode = Node()
                let line = String(lines[i])
                
                let left = line.index(line.startIndex, offsetBy: 7) // What a bind
                let right = line.index(left, offsetBy: 3)
                newNode.left = String(line[left..<right])

                let left2 = line.index(line.startIndex, offsetBy: 12) // What a bind
                let right2 = line.index(left2, offsetBy: 3)
                newNode.right = String(line[left2..<right2])

                let nameRight = line.index(line.startIndex, offsetBy: 3)
                let name: String = String(line[..<nameRight])

                nodes[name] = newNode
            }
        }
    }
}
