//
//  Day04.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 04/12/2023.
//

import Foundation

class Day04 : DayBase {
    
    struct Card {
        var num = 0
        var balls = Set<Int>()
        var draw = Set<Int>()
    }

    var cards = Array<Card>()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 0
        cards.removeAll()
        
        let lines = fileAsLines(filename: filename)
        
        // parse input
        for line in lines {
            if line.count > 0 {
                var newCard = Card()
                let colonSplit = line.split(separator: ":")
                newCard.num = Int(colonSplit[0].split(separator: " ")[1])!
                let numberSplit = colonSplit[1].split(separator: "|")
                for ball in numberSplit[0].split(separator: " ") {
                    newCard.balls.insert(Int(ball)!)
                }
                for draw in numberSplit[1].split(separator: " ") {
                    newCard.draw.insert(Int(draw)!)
                }
                cards.append(newCard)
            }
        }
        
        if part == 1 {
            // Part 1
            for card in cards {
                let intersect = card.balls.intersection(card.draw)
                if intersect.count > 0 {
                    total += Int(pow(Double(2), Double(intersect.count - 1)))
                }
            }
        } else {
            // Part 2
            var numEach = Array<Int>()
            for _ in 0..<cards.count {
                numEach.append(1)
            }
            for i in 0..<cards.count {
                let intersectNum = cards[i].balls.intersection(cards[i].draw).count
                
                for j in 0..<intersectNum {
                    numEach[cards[i].num + j] += numEach[i]
                }
            }
            for i in 0..<numEach.count {
                total += numEach[i]
            }
        }
        return total
    }
}
