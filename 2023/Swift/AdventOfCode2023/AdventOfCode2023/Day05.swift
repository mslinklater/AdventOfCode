//
//  Day05.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 05/12/2023.
//

import Foundation

class Day05 : DayBase {
    
    var seeds = [Int]()
    
    struct Range {
        var start: Int
        var size: Int
    }
    
    struct MappingRange {
        var to = 0
        var from = 0
        var size = 0
    }

    struct Mapping {
        var fromType = ""
        var toType = ""
        var ranges = [MappingRange]()
        var toMappingIndex = 0
        
        func get(_ sourceIndex: Int) -> Int {
            for range in ranges {
                if sourceIndex >= range.from && sourceIndex < range.from + range.size {
                    let diff = range.to - range.from
                    return sourceIndex + diff
                }
            }
            return sourceIndex
        }
        
        func rangeGet(_ source: [Range]) -> [Range] {
            var ret = [Range]()
            for sourceRange in source {
                print("-- source --")
                for range in ranges {
                    print("-- range --")
                    let sourceStart = sourceRange.start
                    let sourceEnd = sourceRange.start + sourceRange.size
                    let rangeStart = range.from
                    let rangeEnd = range.from + range.size
                    let rangeDelta = range.to - range.from
                    print("Splitting \(sourceStart)-\(sourceEnd) by \(rangeStart)-\(rangeEnd)")
                    if sourceEnd < rangeStart {
                        // source lower
                        print("no-change... below")
                        ret.append(sourceRange)
                    } else if sourceStart > rangeEnd {
                        // source higher
                        print("no-change above")
                        ret.append(sourceRange)
                    } else if sourceStart < rangeStart && sourceEnd > rangeEnd {
                        // source covers range - split to 3
                        assert(false, "A")
                    } else if sourceStart > rangeStart && sourceEnd < rangeEnd {
                        // source contained within range - just move it
                        print("contained within... moving \(rangeDelta)")
                        ret.append(Range(start: sourceStart + rangeDelta, size: sourceRange.size))
                    } else if sourceStart > rangeStart && sourceEnd < rangeEnd {
                        // source intersects range start - split to 2
                        assert(false, "C")
                    } else {
                        // source intersects range end - split to 2
                        assert(false, "D")
                    }
                }
            }
            return ret
        }
    }

    var mappings = [Mapping]()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 0

        // clear our data structures
        mappings.removeAll()
        seeds.removeAll()

        parseInput(filename)
        
        if part == 1 {
            // find resulting location from each seed value
            var lowest = Int.max
            for seed in seeds {
                var thisSeed = seed
                for mapping in mappings {
                    thisSeed = mapping.get(thisSeed)
                }
                lowest = min(lowest, thisSeed)
            }
            total = lowest
        } else {
            // find resulting location from each seed value
            var lowest = Int.max
            var iSeed = 0
            while iSeed < seeds.count {
                var ranges = [Range]()
                ranges.append(Range(start: seeds[iSeed], size: seeds[iSeed + 1]))
                
                for mapping in mappings {
                    //let prevSeed = thisSeed
                    ranges = mapping.rangeGet(ranges)
                }
                print(ranges)
                for range in ranges {
                    lowest = min(range.start, lowest)
                }
                iSeed += 2
            }
            total = lowest

        }
        
        return total
    }
    
    func parseInput(_ filename: String) {
        let lines = fileAsLines(filename: filename)
        
        // seeds
        let seedStrings = (lines[0].split(separator: ":")[1]).split(separator: " ")
        for seedString in seedStrings {
            seeds.append(Int(seedString)!)
        }
        
        // mappings
        for iLine in 0 ..< lines.count {
            if lines[iLine].contains("map:") {
                // new mapping block
                var newMapping = Mapping()
                let mappingString = lines[iLine].split(separator: " ")[0]
                newMapping.fromType = String(mappingString.split(separator: "-")[0])
                newMapping.toType = String(mappingString.split(separator: "-")[2])
                var lookAhead = iLine + 1
                while lookAhead < lines.count && lines[lookAhead].count > 0 {
                    let mappingsStrings = lines[lookAhead].split(separator: " ")
                    var newMappingRange = MappingRange()
                    newMappingRange.to = Int(mappingsStrings[0])!
                    newMappingRange.from = Int(mappingsStrings[1])!
                    newMappingRange.size = Int(mappingsStrings[2])!
                    newMapping.ranges.append(newMappingRange)
                    lookAhead += 1
                }
                mappings.append(newMapping)
            }
        }
        // Now setup mapping indices so we can traverse through mappings quickly
    }
}
