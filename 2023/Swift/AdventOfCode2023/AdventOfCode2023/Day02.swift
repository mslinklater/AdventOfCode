//
//  Day02.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 02/12/2023.
//

import Foundation

class Day02 : DayBase {
    
    struct Draw {
        var red = 0
        var green = 0
        var blue = 0
    }
    
    struct Game {
        var number = 0
        var draws = Array<Draw>()
    }
    
    var games: Array<Game> = []
    
    override func run(filename: String, part: Int) -> Int {
        games = Array<Game>()   // clear
        var total = 0
        parseInput(input: fileAsLines(filename: filename))
        if part == 1 {
            let maxRed = 12
            let maxGreen = 13
            let maxBlue = 14
            for game in games {
                var validGame = true
                for draw in game.draws {
                    if draw.red > maxRed || draw.green > maxGreen || draw.blue > maxBlue {
                        validGame = false
                    }
                }
                if validGame {
                    total += game.number
                }
            }
        } else {
            for game in games {
                var maxRed = 0
                var maxGreen = 0
                var maxBlue = 0
                for draw in game.draws {
                    maxRed = max(maxRed, draw.red)
                    maxGreen = max(maxGreen, draw.green)
                    maxBlue = max(maxBlue, draw.blue)
                }
                total += maxRed * maxGreen * maxBlue
            }
        }
        return total
    }
    
    func parseInput(input: Array<String>) {
        var gameNum = 1
        for line in input {
            if line.count > 0 {
                let splits = line.split(separator:":")
                let draws = splits[1].split(separator: ";")
                
                var game = Game()
                for draw in draws {
                    var thisDraw = Draw()
                    
                    let colours = draw.split(separator: ",")
                    for colour in colours {
                        let elements = colour.split(separator: " ")
                        switch elements[1] {
                        case "red":
                            thisDraw.red = Int(elements[0])!
                        case "green":
                            thisDraw.green = Int(elements[0])!
                        case "blue":
                            thisDraw.blue = Int(elements[0])!
                        default:
                            assert(false, "unknown colour")
                        }
                    }
                    game.draws.append(thisDraw)
                }
                game.number = gameNum
                gameNum += 1
                games.append(game)
            }
        }
    }
}
