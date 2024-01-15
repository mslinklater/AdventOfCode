//
//  Day13.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 18/12/2023.
//

import Foundation

class Day13 : DayBase {

    struct Map {
        var cells = [[Bool]]()
        var xSize = 0
        var ySize = 0
        var vertMirror : Int? = nil
        var horizMirror : Int? = nil
    }

    var maps = [Map]()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 0
        maps.removeAll()
        parseFile(filename: filename)
        
        if part == 1 {
            
        } else {
            
        }
        return total
    }
    
    func parseFile(filename: String) {
        
    }
}
