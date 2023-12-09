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
    
    struct Transform {
        var to = 0
        var from = 0
        var size = 0
    }

    struct Mapping {
        var fromType = ""
        var toType = ""
        var transforms = [Transform]()
        var toMappingIndex = 0
        
        func get(_ sourceIndex: Int) -> Int {
            for transform in transforms {
                if sourceIndex >= transform.from && sourceIndex < transform.from + transform.size {
                    let diff = transform.to - transform.from
                    return sourceIndex + diff
                }
            }
            return sourceIndex
        }
        
        func rangeGet(_ sourceIn: [Range]) -> [Range] {
            var source = sourceIn
//            for sourceRange in source {
            for i in 0 ..< source.count {
                print("-- source --")
                for transform in transforms {
                    print("-- transform --")
                    let sourceStart = source[i].start
                    let sourceEnd = source[i].start + source[i].size
                    
                    let transformStart = transform.from
                    let transformEnd = transform.from + transform.size
                    let transformDelta = transform.to - transform.from
                    
                    print("Splitting \(sourceStart)-\(sourceEnd) by \(transformStart)-\(transformEnd):\(transformDelta)")
                    
                    if sourceEnd < transformStart {
                        // source lower
                    } else if sourceStart > transformEnd {
                        // source higher
                    } else if sourceStart < transformStart && sourceEnd > transformEnd {
                        // source covers transform - split to 3
                        print("A")
                    } else if sourceStart >= transformStart && sourceEnd <= transformEnd {
                        // source contained within transform - just move it
                        print("contained within... moving \(transformDelta)")
                        source[i].start += transformDelta
                    } else if sourceStart < transformStart && sourceEnd > transformEnd {
                        // source intersects transform start - split to 2
                        print("C")
                    } else {
                        // source intersects transform end - split to 2
                        source[i].size -= sourceEnd - transformStart
                        var newRange = Range(start:source[i].start + transformDelta, size:sourceEnd - transformStart)
                        source.insert(newRange, at: i + 1)
                        print("D")
                    }
                }
            }
            return source
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
                    var newMappingRange = Transform()
                    newMappingRange.to = Int(mappingsStrings[0])!
                    newMappingRange.from = Int(mappingsStrings[1])!
                    newMappingRange.size = Int(mappingsStrings[2])!
                    newMapping.transforms.append(newMappingRange)
                    lookAhead += 1
                }
                mappings.append(newMapping)
            }
        }
        // Now setup mapping indices so we can traverse through mappings quickly
    }
}
