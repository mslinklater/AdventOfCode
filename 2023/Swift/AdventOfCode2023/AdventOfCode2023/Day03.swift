//
//  Day03.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 03/12/2023.
//

import Foundation

class Day03 : DayBase {
    
    struct Number {
        var value = 0
        var top = 0
        var bottom = 0
        var left = 0
        var right = 0
    }
    
    struct Gear {
        var row = 0
        var col = 0
    }

    var grid = [[Character]]()
    var numbers = [Number]()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 0
        grid = [[Character]]()
        numbers = [Number]()
        parseInput(filename: filename)
        findNumbers()
        if part == 1 {
            // find the numbers with symbols in a surrounding cell and sum
            for number in numbers {
                var foundSymbol = false
                for i in number.left...number.right {
                    foundSymbol = foundSymbol || gridIsSymbol(row: number.top, col: i)
                    foundSymbol = foundSymbol || gridIsSymbol(row: number.bottom, col: i)
                }
                foundSymbol = foundSymbol || gridIsSymbol(row: number.top + 1, col: number.right)
                foundSymbol = foundSymbol || gridIsSymbol(row: number.top + 1, col: number.left)
                if foundSymbol {
                    total += number.value
                }
            }
        } else {
            // find gears
            var gears = [Gear]()
            for row in 0..<grid.count {
                for col in 0..<grid[row].count {
                    if grid[row][col] == "*" {
                        var newGear = Gear()
                        newGear.row = row
                        newGear.col = col
                        gears.append(newGear)
                    }
                }
            }
            // find which gears are next to exactly 2 numbers
            for gear in gears {
                var adjacents = [Number]()
                for number in numbers {
                    if gear.col >= number.left && gear.col <= number.right && gear.row >= number.top && gear.row <= number.bottom {
                        adjacents.append(number)
                    }
                }
                if adjacents.count == 2 {
                    total += adjacents[0].value * adjacents[1].value
                }
            }
        }
        return total
    }
    
    func gridIsSymbol(row: Int, col: Int) -> Bool {
        if col >= 0 && col < grid[0].count && row >= 0 && row < grid.count {
            return grid[row][col] != "."
        }
        return false
    }
    
    func findNumbers() {
        for row in 0..<grid.count {
            var col = 0
            while col < grid[row].count {
                if grid[row][col] >= "0" && grid[row][col] <= "9" {
                    // found a number
                    var newNumber = Number()
                    newNumber.left = col - 1
                    newNumber.top = row - 1
                    newNumber.bottom = row + 1
                    newNumber.value = grid[row][col].wholeNumberValue!
                    col += 1
                    while col < grid[row].count && grid[row][col] >= "0" && grid[row][col] <= "9" {
                        newNumber.value *= 10
                        newNumber.value += grid[row][col].wholeNumberValue!
                        col += 1
                    }
                    newNumber.right = col
                    numbers.append(newNumber)
                }
                col += 1
            }
        }
    }
    
    func parseInput(filename: String) {
        let lines = fileAsLines(filename: filename)
        // fill the grid with the characters from the input
        for line in lines {
            if line.count > 0 {
                var newLine = [Character]()
                for c: Character in line {
                    newLine.append(c)
                }
                grid.append(newLine)
            }
        }
    }
}
