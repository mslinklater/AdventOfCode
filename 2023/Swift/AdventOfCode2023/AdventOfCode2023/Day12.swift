//
//  Day12.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 14/12/2023.
//

import Foundation

class Day12 : DayBase {
    
    struct Record {
        var size = 0        // bitmask
        var springs = 0     // bitmask
        var unknowns = 0    // bitmask
        var pattern = [Int]()
    }
    
    var records = [Record]()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 0
        
        parse(filename)
        
        if part == 1 {
            
        } else {
            
        }
        return total
    }
    
    func parse(_ filename: String) {
        let lines = fileAsLines(filename: filename)
        for line in lines {
            var newRecord = Record()
            let pat = line.split(separator: " ")[0]
            let seq = line.split(separator: " ")[1]
            
            // setup the pattern
            let charSize = pat.count
            var currChar = charSize - 1
            for char in pat {
                newRecord.size |= 1 << currChar
                
                
                currChar -= 1
            }
            records.append(newRecord)
        }
    }
}
