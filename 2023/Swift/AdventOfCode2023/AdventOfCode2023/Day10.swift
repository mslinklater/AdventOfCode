//
//  Day10.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 10/12/2023.
//

import Foundation

class Day10 : DayBase {
    
    enum Direction {
        case north
        case south
        case east
        case west
    }

    class Cell {
        var north: Bool = false
        var south: Bool = false
        var east: Bool = false
        var west: Bool = false
        var start: Bool = false
        var vertPipe: Bool = false
        var horizPipe: Bool = false
        var ground: Bool = false
        var inside1: Bool = false
        var inside2: Bool = false
        var distanceFromStart: Int?
    }
    
    var map = [[Cell]]()
    var mapHeight = 0
    var mapWidth = 0

    struct Position {
        var x: Int = 0
        var y: Int = 0
        var lastMove: Direction?
        
        mutating func move(directions: [Direction]) {
            for d in directions {
                if lastMove == nil || d != lastMove! {
                    move(dir: d)
                    return
                }
            }
        }
        
        mutating func move(dir: Direction) {
            switch dir {
            case .east:
                x += 1
                lastMove = .west
            case .west:
                x -= 1
                lastMove = .east
            case .north:
                y -= 1
                lastMove = .south
            case .south:
                y += 1
                lastMove = .north
            }
        }
    }

    var startPosition = Position()
    var head = Position()
    var tail = Position()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 0
        map.removeAll()
        
        parseFile(filename: filename)
        if part == 1 {
            head = startPosition
            tail = startPosition
            // find two valid routes out of the start
            
            let exits = validExits(pos: startPosition)
            head.move(dir: exits[0])
            tail.move(dir: exits[1])
            total += 1
            while head.x != tail.x || head.y != tail.y {
                // traverse
//                print("---")
//                print("head=\(head) tail=\(tail)")
                head.move(directions: validExits(pos: head))
                tail.move(directions: validExits(pos: tail))
                total += 1
            }
        } else {
            // TODO - build grid of vertices and break links with pipe shapes
            // flood from perimeter then count fully surrounded ground squares
            
        }
        
        return total
    }

    func validExits(pos: Position) -> [Direction] {
        var exits = [Direction]()
        let cell = map[pos.y][pos.x]

        // valid west
        if pos.x > 0 && cell.west && map[pos.y][pos.x - 1].east {
            exits.append(Direction.west)
        }
        // valid east
        if pos.x < mapWidth - 1 && cell.east && map[pos.y][pos.x + 1].west {
            exits.append(Direction.east)
        }
        // valid north
        if pos.y > 0 && cell.north && map[pos.y - 1][pos.x].south {
            exits.append(Direction.north)
        }
        // valid south
        if pos.y < mapHeight - 1 && cell.south && map[pos.y + 1][pos.x].north {
            exits.append(Direction.south)
        }
        return exits
    }
    
    func parseFile(filename: String) {
        let lines = fileAsLines(filename: filename)
        var y = 0
        mapHeight = 0
        for line in lines {
            if line.count > 0 {
                var newRow = [Cell]()
                var x = 0
                for char in line {
                    var newCell = Cell()
                    switch char {
                    case "|":
                        newCell.north = true
                        newCell.south = true
                        newCell.vertPipe = true
                    case "-":
                        newCell.east = true
                        newCell.west = true
                        newCell.horizPipe = true
                    case "7":
                        newCell.west = true
                        newCell.south = true
                    case "F":
                        newCell.south = true
                        newCell.east = true
                    case "L":
                        newCell.north = true
                        newCell.east = true
                    case "J":
                        newCell.north = true
                        newCell.west = true
                    case "S":
                        newCell.start = true
                        newCell.north = true
                        newCell.south = true
                        newCell.east = true
                        newCell.west = true
                        startPosition.x = x
                        startPosition.y = y
                    case ".":
                        newCell.ground = true
                    default:
                        ()
                    }
                    newRow.append(newCell)
                    x += 1
                }
                mapWidth = x
                map.append(newRow)
                y += 1
                mapHeight += 1
            }
        }
    }
}
