//
//  DayBase.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 26/11/2023.
//

import Foundation

class DayBase {
    func run(filename: String, part: Int) -> Int {
        return 0
    }
    
    func fileAsLines(filename: String) -> [String]
    {
        let root = "/Users/link/Code/AdventOfCode/2023/Swift/AdventOfCode2023/AdventOfCode2023/Input/"
        var ret = Array<String>()

        do {
            let url = URL(filePath: root + filename)
            let possList: String? = try String.init(contentsOf: url)
            if let list = possList {
                ret = list.components(separatedBy: "\n")
            }
        } catch {
            print(error)
        }

        return ret
    }
}
